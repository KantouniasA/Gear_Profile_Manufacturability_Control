function  [xc,yc,xr,yr,xp2,yp2] = Profile2Contact(xp1,yp1,ro1,ro2)
%% Inputs
% kartesian system with center of the gear center
% gear1 profile coordinates (xp1,yp2)
% radial of gear1 gear2 respectively ro1 ro2

%% Outputs
% gear 2 profile (xp2,yp2)
% contact profile (xc,yc)
% rule profile (xr,yr)

%% Calcultions of contact
yp1 = yp1+ro1;
xc = zeros(1,length(xp1));
yc = zeros(1,length(xp1));

%frong calculation
theta = atan_new(yp1(3)-yp1(1),xp1(3)-xp1(1));
[xp11,yp11] = Axis_Rot(xp1(1:3),yp1(1:3),theta,0,0);
dy_dx = array_diff(yp11,xp11);
rgG = (xp11(1)+yp11(1).*dy_dx(1))./sqrt(1+dy_dx(1).^2);
rG = sqrt(xp11(1).^2+yp11(1).^2);
xc(1) = rgG.*(sqrt((rG/ro1).^2-(rgG./ro1).^2)-sqrt(1-(rgG./ro1).^2));
yc(1) = xc(1).*sqrt((ro1./rgG).^2-1);

%check for the slope of the profile in order to be revolved in case thate there is change in slope
theta_ver = atan_new(yp1(1),xp1(1));
[xp1_ver,yp1_ver] = Axis_Rot(xp1(1:3),yp1(1:3),-theta_ver,0,-ro1);
dy_dx_dok = array_diff(yp1_ver(1:3),xp1_ver(1:3));
if dy_dx_dok(1)<0
    xc(1) = -xc(1);
end

%middle calculation
for n = 2:length(xp1)-1
    theta = atan_new(yp1(n+1)-yp1(n-1),xp1(n+1)-xp1(n-1));
    [xp11,yp11] = Axis_Rot(xp1(n-1:n+1),yp1(n-1:n+1),theta,0,0);
    dy_dx = array_diff(yp11,xp11);
    rgG = (xp11(2)+yp11(2).*dy_dx(2))./sqrt(1+dy_dx(2).^2);
    rG = sqrt(xp11(2).^2+yp11(2).^2);
    xc(n) = rgG.*(sqrt((rG/ro1).^2-(rgG./ro1).^2)-sqrt(1-(rgG./ro1).^2));
    yc(n) = xc(n).*sqrt((ro1./rgG).^2-1);

    %check for the slope of the profile in order to be revolved in case thate there is change in slope
    theta_ver = atan_new(yp1(n),xp1(n));
    [xp1_ver,yp1_ver] = Axis_Rot(xp1(n-1:n+1),yp1(n-1:n+1),-theta_ver,0,-ro1);
    dy_dx_dok = array_diff(yp1_ver(1:3),xp1_ver(1:3));
    if dy_dx_dok(2)<0
        xc(n) = -xc(n);
    end
end

%rear calculation
theta = atan_new(yp1(end)-yp1(end-2),xp1(end)-xp1(end-2));
[xp11,yp11] = Axis_Rot(xp1(end-2:end),yp1(end-2:end),theta,0,0);
dy_dx = array_diff(yp11,xp11);
rgG = (xp11(3)+yp11(3).*dy_dx(3))./sqrt(1+dy_dx(3).^2);
rG = sqrt(xp11(3).^2+yp11(3).^2);
xc(end) = rgG.*(sqrt((rG/ro1).^2-(rgG./ro1).^2)-sqrt(1-(rgG./ro1).^2));
yc(end) = xc(end).*sqrt((ro1./rgG).^2-1);

%check for the slope of the profile in order to be revolved in case thate there is change in slope
theta_ver = atan_new(yp1(end),xp1(end));
[xp1_ver,yp1_ver] = Axis_Rot(xp1(end-2:end),yp1(end-2:end),-theta_ver,0,-ro1);
dy_dx_dok = array_diff(yp1_ver(1:3),xp1_ver(1:3));
if dy_dx_dok(3)<0
    xc(end) = -xc(end);
end

%% Calculation of rule
dy_dx = array_diff(yc,xc);
f_int = 1+yc./xc.*dy_dx;
K = array_int(f_int,xc);
yr = yc;
xr = xc - K;

%% Calculation of gear 2
theta1 = K/ro1;
theta2 = -theta1*ro1/ro2;
xp2 = xc.*cos(theta2)-(yc-ro2).*sin(theta2);
yp2 = xc.*sin(theta2)+(yc-ro2).*cos(theta2)+ro2;
end