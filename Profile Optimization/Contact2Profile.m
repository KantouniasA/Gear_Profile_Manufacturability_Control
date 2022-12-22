function [xf1,yf1,xf2,yf2,xr,yr] = Contact2Profile(xc,yc,ro1,ro2)
%% Inputs
% yc = f(xc) [array elements, the contact orbit of teeth]
% ro1 [number, pitch cycle radius of the gear1]
%% Outputs
% xf1, yf1, cartesian cordinates of gear profile
% xr1, yr1, cartsian cordinates of rule profile
%% Calculcalations of rule1
dy_dx = array_diff(yc,xc);
f_int = 1+yc./xc.*dy_dx;
K = array_int(f_int,xc);
yr = yc;
xr = xc - K;
%% Calculation of gear1 profile
theta1 = K./ro1;
xf1 = xc.*cos(theta1)-(yc+ro1).*sin(theta1);
yf1 = xc.*sin(theta1)+(yc+ro1).*cos(theta1)-ro1;
%% Calculation of gear2 profile
theta2 = -theta1*ro1/ro2;
xf2 = xc.*cos(theta2)-(yc-ro2).*sin(theta2);
yf2 = xc.*sin(theta2)+(yc-ro2).*cos(theta2)+ro2;
end

