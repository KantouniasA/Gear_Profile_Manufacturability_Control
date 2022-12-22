function [phi] = atan_new(y,x)
    if x>=0 && y>0
        phi = atan(y/x);
    elseif y>=0 && x<=0
        phi = pi+atan(y/x);
    elseif y<=0 && x<=0
        phi = pi+atan(y/x);
    else
        phi = 2*pi+atan(y/x);
    end
end