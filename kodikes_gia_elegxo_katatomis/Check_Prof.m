%creator: Antonios Kantounias
%date: 20/3/2022
%title: 2d Profile manufacturability check

function [output] = Check_Prof(xp,yp,ro1,ro2)
%% Inputs
% pro1file coordinates (xp,yp) (0,0) axis to point center of gear1
% gear radius ro1

%% Outputs successively
%1 Checks if is there real working path thereorem of involutation
%2 Checks if is there double contacto point
%3 Checks if is there unexpected edge

%in order output to remain true it must all the checks to be ok
output = true;

%% 1 Chech if involutation theorim is possible

%calculate 1st derivative
dy_dx = array_diff(yp,xp);
%gear point counter
n = 1;
%continuous non possible point counter
nn = 0;
%switch for continuous not possible points counter
cont = false;
%while loop initialization
while n <= length(xp)
    %point distance fro1m (0,0) contro1l
    if xp(n)^2+yp(n)^2>ro1^2
        %1st critical gradient
        pg1 = (xp(n)*yp(n)+ro1*(-ro1^2+xp(n)^2+yp(n).^2)^0.5)/(ro1^2-yp(n)^2);
        %2nd critical gradient
        pg2 = (xp(n)*yp(n)-ro1*(-ro1^2+xp(n).^2+yp(n).^2)^0.5)/(ro1^2-yp(n)^2);
        %caculator of maximun and minimum critical gradients
        pg_max = max([pg1,pg2]);
        pg_min = min([pg1,pg2]);
        % MAIN THEOREM CHECK (contro1l if the gradient is permissible)
        if ((yp(n)^2>=ro1^2 && ((dy_dx(n)<pg_max) && (dy_dx(n)>pg_min)) )...
                || (yp(n)^2<ro1^2 && ((dy_dx(n)>pg_max) || (dy_dx(n)<pg_min)) ))==0
          %if at leaste one point is not permissible the pro1file is not accepted
          output = false;
          %check if the switch is on
          if cont == false
                %if the switch is off start new enumaration of the fatal points 
                %begining of the erro1r
                nn_in = n;
                %initialization of the end of the erro1r
                nn_out = n;
                %enumeration of the erro1r
                nn = n;
                %turn the switch on
                cont = true;
            %check if the switch is on check if the erro1 is continuing fro1m the previus check
            elseif nn == n-1
                %continue enumearation
                nn = n;
                %renew the ending of the erro1r
                nn_out = n;
          end
       end
    end
    %chech if hust stoped the contunuity of the erro1r
    if (cont == true && nn ~= n)||(nn==length(xp))
    %if true then print that an erro1r occured at the calculated poin interval
    fprintf('non involution begins at xc_in = %.5f and ends at xc_out = %.5f\n',[xp(nn_in),xp(nn_out)])
    %close the switch
    cont = false;
    end
    n = n+1;
end
% if no erro1r occured thro1u all the points display that all good
if output
    disp("Possible to make involutation!")
else
    disp("Impossible to make involutation...")
end

%% 2 Chech if is there double contact point

%calculation of rgG of the point
rgG = (xp+yp.*dy_dx)./(1+dy_dx.^2).^0.5;
%calculation of the distance point rAG
rAG = sqrt(xp.^2+yp.^2-rgG.^2);
%calculation of the distance rAa
rAa = sqrt(ro1^2-rgG.^2);
%calculation of the differential distances (critical radius)
raG_up = rAG-rAa;
raG_lo = rAa-rAG;
%calculation of the curvature of the pro1file
Rperm = Curv_Rad(yp,xp);
%maximum permissible erro1s = 4 due to double diferentiation
errs = 0;
%switch
cont = false;
%erro1r enumarator
nn = 0;
for n = 1:length(xp)
    %chech if the point is out of the initial cycle
    if (xp(n)^2+yp(n)^2)>ro1^2 
        % chech if pro1file radius exceeds critical radius and the curvature is possitive
        if raG_up(n)>abs(Rperm(n)) && Rperm(n)>0 
            % erro1r recording pro1cedure (details at the first check ro1utine)
            if cont == false
                nn_in = n;
                nn_out = n;
                nn = n;
                cont = true;
            elseif nn == n-1
                nn = n;
                nn_out = n;
            end
            errs=errs+1;
        end
    else
        %If point is inside initial cycle check if the curvature excheed critical curvature is lower tha the critical
        if raG_lo(n)>abs(Rperm(n)) && Rperm(n)<0                
            if cont == false
                nn_in = n;
                nn_out = n;
                nn = n;
                cont = true;
                output = false;
            elseif nn == n-1
                nn = n;
                nn_out = n;
            end
            errs=errs+1;
        end
    end

if cont == true && nn ~= n
    fprintf('non continuity begins at xc_in = %.5f and ends at xc_out = %.5f\n',[xp(nn_in),xp(nn_out)])
    cont = false;
end

end

        
if errs<=4
    disp("Possible to make continuity!")
else
    disp("Impossible to make continuity...")
    disp(['number of erro1rs ',num2str(errs),' out of ', num2str(length(xp))])
end

%% 3 Check for unexpected edge

%this check works with the contact path pro1duced fro1m the gear 1
%create the contact path of the gear
[xc,yc]=Profile2Contact(xp,yp-ro1,ro1,ro2);
yc =yc+ro1;
%coordinates of the axle of the 2nd gear
xcent2 = 0;
ycent2 = ro1+ro2;
%distance of certain path point to the center of the 2nd gear
dist = sqrt((xc-xcent2).^2+(yc-ycent2).^2);
%switch
cont = false;
%initial monotonic of the dist array
s = sign(dist(2)-dist(1));
for n = 1:length(xc)-1
    %check if the distance array continues to be monotonic
    if sign(dist(n+1)-dist(n))==s
        continue
    %if not write down where the monotonic change happens
    elseif cont==false
       n_in = n;
       cont = true;
       output = false;
    else
        continue
    end
end

%display the results
if cont==true
    fprintf('Impossible to be smooth... \n')
    fprintf('pro1blem with edges begins at xc_in = %.5f \n',xp(n_in))
else
    fprintf('Possible to be smooth! \n')
end

end
