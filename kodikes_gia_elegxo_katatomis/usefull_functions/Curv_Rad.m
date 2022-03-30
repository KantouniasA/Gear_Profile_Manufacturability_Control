function [Radius] = Curv_Rad(y,x)
%% Inputs 
% Gradient dy_dx, Curvature ddy_ddx

%% Outputs
% Curv radious
Radius = zeros(1,length(x));

%% Calcs
%front radius calculation

%turn the axis to the point x1,y1 for rubustness in calculations
phi = atan_new(x(1),y(1));
[xt,yt] = Axis_Rot(x(1:3),y(1:3),-phi,0,0);
%rotate a small part of the curve 
theta  = atan((yt(3)-yt(1))/(xt(3)-xt(1)));
[xt,yt] =  Axis_Rot(xt,yt,-theta,0,0);
%calculate the 1st and 2nd derivative
[dyt_dxt,ddyt_ddxt] = array_diff(yt,xt);
%calculate the radius
Radius(1) = (1+dyt_dxt(1).^2).^(3/2)./ddyt_ddxt(1);

%middle curve radius calculation
for n = 2:length(x)-1
    phi = atan_new(x(n),y(n));
    [xt,yt] = Axis_Rot(x(n-1:n+1),y(n-1:n+1),-phi,0,0);
    theta = atan((yt(3)-yt(1))/(xt(3)-xt(1)));
    [xt,yt] = Axis_Rot(xt,yt,-theta,0,0);
    [dyt_dxt,ddyt_ddxt] = array_diff(yt,xt);
    Radius(n) = (1+dyt_dxt(2).^2).^(3/2)./ddyt_ddxt(2);
end

%back curve radius calculation
phi =atan_new(x(end),y(end));
[xt,yt] = Axis_Rot(x(end-2:end),y(end-2:end),-phi,0,0);
theta  = atan((yt(3)-yt(1))/(xt(3)-xt(1)));
[xt,yt] =  Axis_Rot(xt,yt,-theta,0,0);
[dyt_dxt,ddyt_ddxt] = array_diff(yt,xt);
Radius(end) = (1+dyt_dxt(3).^2).^(3/2)./ddyt_ddxt(3);

end
