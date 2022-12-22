function [theta_con] = theta_contact(xG,yG,ro)
% ypologize tin gonia pou brisketai to simeio epafis me ton aksona (0,0) gia kathe simio tis katatomis
yG = yG+ro;
rG = sqrt(xG.^2+yG.^2);
rg = rg_calc(xG,yG);
theta_con = acos(rg./rG)-acos(rg./ro);
end

function [rg] = rg_calc(xG,yG)
rg = zeros(1,length(xG));
theta = atan_new(yG(3)-yG(1),xG(3)-xG(1));
[xp11,yp11] = Axis_Rot(xG(1:3),yG(1:3),theta,0,0);
dy_dx = array_diff(yp11,xp11);
rg(1) = (xp11(1)+yp11(1).*dy_dx(1))./sqrt(1+dy_dx(1).^2);

for n = 2:length(xG)-1
    theta = atan_new(yG(n+1)-yG(n-1),xG(n+1)-xG(n-1));
    [xp11,yp11] = Axis_Rot(xG(n-1:n+1),yG(n-1:n+1),theta,0,0);
    dy_dx = array_diff(yp11,xp11);
    rg(n) = (xp11(2)+yp11(2).*dy_dx(2))./sqrt(1+dy_dx(2).^2);
end

theta = atan_new(yG(end)-yG(end-2),xG(end)-xG(end-2));
[xp11,yp11] = Axis_Rot(xG(end-2:end),yG(end-2:end),theta,0,0);
dy_dx = array_diff(yp11,xp11);
rg(end) = (xp11(3)+yp11(3).*dy_dx(3))./sqrt(1+dy_dx(3).^2);
end