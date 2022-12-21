function [phi] = atan_new(y,x)
%% calculation of an angle from [0 2pi]
    
    %1st quarter
    if x>=0 && y>0
        phi = atan(y/x);
    %2nd quarter
    elseif y>=0 && x<=0
        phi = pi+atan(y/x);
    %3rd quarter
    elseif y<=0 && x<=0
        phi = pi+atan(y/x);
    %4th quarter
    else
        phi = 2*pi+atan(y/x);
    end
end