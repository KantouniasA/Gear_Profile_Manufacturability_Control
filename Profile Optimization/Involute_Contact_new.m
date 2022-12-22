function [x_cnt, y_cnt, ro1 ,ro2] = Involute_Contact_new(Z1,Z2,m)
%%
%eksagogi tis troxia epafon tis eksiligmenis gia dedomeno modul kai arithmo
%odonton. 
%%
div = 5000; %# of nodes
ao = 20*pi/180; %pressure angle
%%
do1 = Z1*m; ro1 = do1/2; %pitch circle diameter
do2 = Z2*m; ro2 = do2/2; %pitch circle diameter
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
x_cnt = linspace(x_start,x_end,div);%linspace(-ro*sin(ao)*1,ro*sin(ao)*1,div);
y_cnt = x_cnt*tan(ao);
end