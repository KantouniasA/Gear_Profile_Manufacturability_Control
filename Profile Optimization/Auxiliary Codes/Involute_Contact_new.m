function [x_cnt, y_cnt, ro1 ,ro2] = Involute_Contact_new(Z1,Z2,m,ao)
%% Involute_Contact_new 
%  Involute_Contact_new calculate the contact path for a pair of working gears
%   Inputs
%       Z1,Z2   Number of teeths of gear 1 and gear 2
%       m       Gear teeth module
%       ao      Pressure angle
%   Outputs 
%       x_cnt, y_cnt    Contact profile line coordinates
%       ro1,ro2         Rolling cycles of gear 1 and gear 2
%
%   Author: Antonios Kantounias 2022/12/22, antonis.kantounias@gmail.com

%% Inputs
div = 5000;                             % # of nodes
%% Calculate contact path for involute profile
do1 = Z1*m; 
ro1 = do1/2;                            % Pitch circle diameter
do2 = Z2*m; 
ro2 = do2/2;                            % Pitch circle diameter
rk1 = ro1+m;
rk2 = ro2+m;
rb1 = ro1*cos(ao);
rb2 = ro2*cos(ao);
c3  = sqrt(ro1^2-rb1^2);
c6  = (ro1+ro2)*sin(ao);
c1  = c6-sqrt(rk2^2-rb2^2);
c5  = sqrt(rk1^2-rb1^2);
x_start = -(c3-c1)*cos(ao);
x_end   = (c5-c3)*cos(ao);
x_cnt   = linspace(x_start,x_end,div);
y_cnt   = x_cnt*tan(ao);
end