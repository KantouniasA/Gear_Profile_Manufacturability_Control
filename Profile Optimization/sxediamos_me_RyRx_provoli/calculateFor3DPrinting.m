clear
close all
addpath('..\')
%% Initial cycles - involute creation
z1      = 75;
z2      = 25;
module  = 1.5;
iter    = 40;
ao      = 20*pi/180;

% Calculation of contact profile
[xc1,yc1, ro1 ,ro2] = Involute_Contact_new(z1,z2,module,ao);

% Calculation of gear profile
[xp1,yp1]           = Contact2Profile(xc1,yc1,ro1,ro2);

% Calculation of gear profile 2 using the theory of involuatioation
[xcc,ycc,xrc,yrc,xp2,yp2] = Profile2Contact(xp1,yp1,ro1,ro2);
xp11 = xp1; yp11 = yp1; xp22 = xp2; yp22 = yp2;

%% Calculation of the undercuts
numOfPlanes     = 5; 
yAngularError   = 0*pi/180;
gearThickness  	= 15;
Ry              = ro1;
xAngularError   = asin((gearThickness/2)/Ry);

xAngularErrors  = linspace(0,xAngularError,numOfPlanes);
yAngularErrors  = linspace(0,yAngularError,numOfPlanes);
gearThicknesses = linspace(0,gearThickness,numOfPlanes);
for iPlane = 1:numOfPlanes
[x1_cent,y1_cent,x2_cent,y2_cent,x1_imag,y1_imag,x2_imag,y2_imag,dthick2] = ypokopi_calc_V3(xcc,ycc,ro1,ro2,xAngularErrors(iPlane),yAngularErrors(iPlane),Ry);
tt1 = -(gearThicknesses(iPlane)*ones(1,length(x1_imag))/2);
tt2 = -(dthick2);
xyimag1 = [x1_imag',y1_imag'+ro1,tt1'];
xyimag1 = [xyimag1(1,:);xyimag1(5:end-20,:)];
xyimag2 = [x2_imag',y2_imag'+ro1,tt2'];
xyimag2 = [xyimag2(1,:);xyimag2(5:end-20,:)];
txtname1 = sprintf('g1_data%d.txt',iPlane);
writematrix(xyimag1,txtname1);
txtname2 = sprintf('g2_data%d.txt',iPlane);
writematrix(xyimag2,txtname2);

figure(1)
hold on
plot3(xyimag1(:,1),xyimag1(:,3),xyimag1(:,2))
plot3(xyimag2(:,1),xyimag2(:,3),xyimag2(:,2))
hold off
axis equal

figure(2)
hold on
plot(xyimag1(:,1),xyimag1(:,2))
plot(xyimag2(:,1),xyimag2(:,2))
hold off
axis equal

end























