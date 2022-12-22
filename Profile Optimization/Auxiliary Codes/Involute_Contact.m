function [x_cnt, y_cnt, ro] = Involute_Contact(Z,m)
%%
%eksagogi tis troxia epafon tis eksiligmenis gia dedomeno modul kai arithmo
%odonton. 
%%
div = 5000; %# of nodes
ao = 20*pi/180; %pressure angle
%%
do = Z*m; ro = do/2; %pitch circle diameter
x_cnt = linspace(-4.8,4.8,div);%linspace(-ro*sin(ao)*1,ro*sin(ao)*1,div);
y_cnt = x_cnt*tan(ao);
end