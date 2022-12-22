function [x1_imag,y1_imag,x2_imag,y2_imag,dthick2] = ypokopi_calc_V3(xe,ye,ro1,ro2,xerror,yerror,Ry,Rx,ty,tx)
%% simiosis 
% to paron programa leitourgei mono me katotomi ekseligmenis me mikri
% metatropi mporei na leitourgisei gia oles tis katatomes

%% Coordinates
% z einai o aksonas tou paxous tou troxou
% y einai o aksona pou orizetai apo ta dio kentra ton troxon
% x einai o katheto sto yz epipedo aksonas 
% cartesiano systima sintetagmenon me kentro to simio epafis ton kyklo kilisis ton dyo troxon

%% Inputs
% xe ye :troxia epafon tis ekkentris katatomis me tin opoia tha sxediastei o sinergazomenos troxos
% ro1 ro2 :aktines kilisis tou sinergazomenou kai tou ekkentrou troxou antistixa
% xerror yerror :gonies sfalmatos me basi tis opoies tha sxediastei o sinergazomenos troxos
% (Ry,ty) sxetiki thesi tou kentrou tou sfalmatos 'xerror' apo to kato simio tou kyklou kilisis tis ekentris katatomis sto epipedo YZ
% (Rx,tx) sxeitiki thesi tou kentrou tou sfalmatos 'yerror' apo to kato simio tou kyklou kilisis tis ekentris katatotomis sto epipedo XZ

%% Outputs
% (x1_imag, y1_imag) tou ekentrou troxou
% (x2_imag, y2_imag) h katatomi tou sinergazomenou troxou
% (dthick2) oi sintetagmenes sxediasis tis sinergazomenis katatomis kata ton aksona z

%% main program
%% prokataktikoi ypologismoi 

xetip_over          = xe; %arxika simia tis sinergazomenis katatomis (troxia epafon)
yetip_over          = ye; 
xe                  = xe(1:10:end); %arxika simia tis ekkentris katatomis (troxia epafon)
ye                  = ye(1:10:end);
[x_imag,y_imag]     = Contact2Profile(xetip_over*1,yetip_over*1,ro1,ro2); % arxika simia sinergazomenis katatomis 
[x1_cent,y1_cent,~] = Contact2Profile(1*xe,1*ye,ro1,ro2);% arxika simia ekkentris katatomis

%metakinisi tis katatatomis_imag pano stin ketnriki (proeretika gia thnperiiptosi tis pou kano xrisi ekseligmenis)
th_cent             = theta_contact(x1_cent,y1_cent,ro1);

%arxikopoiisi
x2_imag = zeros(1,length(th_cent));
y2_imag = zeros(1,length(th_cent));
x1_imag = zeros(1,length(th_cent));
y1_imag = zeros(1,length(th_cent));
dthick2 = zeros(1,length(th_cent));

%% gia kathe simio tis ekkentris katatomis eyresh tou antistixou simiou tis sinergazomenis katatomis
for n = 1:length(th_cent)
[x_1imag_n,y_1imag_n,x_2imag_n,y_2imag_n,dthick2_n] = find_th_eq(x_imag,y_imag,x1_cent(n),y1_cent(n),th_cent(n),xerror,yerror,ro1,ro2,Ry,Rx,ty,tx);
x1_imag(n) = x_1imag_n;
y1_imag(n) = y_1imag_n;
x2_imag(n) = x_2imag_n;
y2_imag(n) = y_2imag_n;
dthick2(n) = dthick2_n;
end

%ksefortoma ton simio pou den brethike antistixo
x1_imag = rmmissing(x1_imag);
y1_imag = rmmissing(y1_imag);
x2_imag = rmmissing(x2_imag);
y2_imag = rmmissing(y2_imag);
dthick2 = rmmissing(dthick2);
if length(x1_imag)~=length(y1_imag)||length(x2_imag)~=length(y2_imag)
    disp('error debug ypokopi_calc_V3')
end

end

function[x1_imag,y1_imag,x2_imag,y2_imag,dthick2] = find_th_eq(x_imag,y_imag,x_real,y_real,dth,xerror,yerror,ro1,ro2,Ry,Rx,ty,tx)
% find_th_eq
%
% Inputs
%   dth     angle [rad] of contact related to y axis 
%
% Outputs
%
% Author: Antonios Kantounias, 2022.12.22, antonis.kantounias@gmail.com


%% Rotate the profile to the contact point
% Calculate the angle from y axis 
dth_in = dtheta_calc(0,0,x_real,y_real,ro1);

% Sum the tow angle to calculate the final rotation
dth_tot = dth_in+dth;
[x_imag,y_imag] = Axis_Rot(x_imag,y_imag,dth_tot,0,-ro1);
[x_real,y_real] = Axis_Rot(x_real,y_real,dth_tot,0,-ro1);

%% Contact point displacement due to thickness (1st Difference)
Dy = sin(xerror)*ty/2;
Dx = sin(yerror)*tx/2;

%% Contact point displacement throught thickness axis due to angular error  (3d Difference)
dthick2 = (Ry-y_real)*sin(xerror)+(Rx-x_real)*sin(yerror);

%%  (2nd Difference)
dx = (1-cos(yerror))*(Rx-x_real);
dy = (1-cos(xerror))*(Ry-y_real);

%%  (4th Difference)
met1 = cos(xerror);
met2 = cos(yerror);
yy = y_real+ro1;
xx = x_real-0;
phi = atan(xx/yy);
met_tot = sqrt((met2*cos(phi))^2+(met1*sin(phi))^2);
dro1_sxet = -ro1*(1-met_tot); %thesi tou ano simiou tou sxetikou kiklou kilisis

%% Ypologismos tou sinergazomenou troxou
% Metatopisi tou ximag, yimag
x_imag = x_imag+Dx+dx;
y_imag = y_imag+Dy+dy;

% Calculate slope at each relative profile point
PG = array_diff(y_imag,x_imag); 

% Find the relative profile point that meets the contact ---- 
[min_dev,idx] = min(abs(-1./(-abs(PG))-y_imag./x_imag));
xeq = x_imag(idx);
yeq = y_imag(idx);

% Rotation of the contact point to the initial location for gear 1
[x1_imag,y1_imag] = Axis_Rot(x_real,y_real,-dth_tot,0,-ro1);

% Rotation of the contact point to the initial location for gear 2
[x2_imag,y2_imag] = Axis_Rot(xeq,yeq,dth_tot*(ro1+dro1_sxet)/ro2,0,ro2);

%% elegxos yparksis simeiou apoklisi > 10^(-3) den theorite apodekti
if min_dev>1e-3
    x1_imag = nan;
    y1_imag = nan;
    x2_imag = nan;
    y2_imag = nan;
    dthick2 = nan;
end

end


