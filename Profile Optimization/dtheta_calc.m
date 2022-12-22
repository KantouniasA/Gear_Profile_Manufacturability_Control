function [theta] = dtheta_calc(xG,yG,xe,ye,ro)
%% metafora systimatos oste h aktina oste kentro troxou = (0,0)
yG = yG+ro;
ye = ye+ro;

%% peristofi ton aksonon kata gonia dphi oste to simio G na pataei ston aksona y
dphi = atan_new(yG,xG);
[xG,yG] = Axis_Rot(xG,yG,-dphi,0,0);
[xe,ye] = Axis_Rot(xe,ye,-dphi,0,0);

%% euresi gonias peri epafis
    theta = acos((xG*xe+yG*ye)/sqrt((xG^2+yG^2)*(xe^2+ye^2))); 
end
