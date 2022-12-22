clear
addpath('..\')
%% initial cycles - involute creation
z1 = 20;
z2 = 25;
module = 1.5;
iter = 40;
ao = 20*pi/180;
[~,~,ro1] = Involute_Contact(z1,module);
[~,~,ro2] = Involute_Contact(z2,module);
[xc1,yc1,~] = Involute_Contact(z1,module);
[xp1,yp1] = Contact2Profile(xc1,yc1,ro1,ro2);

%% theory of involutation
[xcc,ycc,xrc,yrc,xp2,yp2] = Profile2Contact(xp1,yp1,ro1,ro2);
xp11 = xp1; yp11 = yp1; xp22 = xp2; yp22 = yp2;
%% ypologismos ypokopis
tgear = 4;
tg = tgear/2;
Ry = 60;
Rx = 30;
sxsy = 2;
yerror = asin(tg/(Rx+Ry*sxsy));
xerror = asin(sin(yerror)*sxsy);
planes = 4; %arithmos epipesdon
xerrors = linspace(0,xerror,planes);
yerrors = linspace(0,yerror,planes);
tgears = linspace(0,tgear,planes);
for n = 1:planes
[x1_cent,y1_cent,x2_cent,y2_cent,x1_imag,y1_imag,x2_imag,y2_imag,dthick2] = ypokopi_calc_V3(xcc,ycc,ro1,ro2,xerrors(n),yerrors(n),Ry,Rx);
tt1 = -(tgears(n)*ones(1,length(x1_imag))/2);
tt2 = -(dthick2);
xyimag1 = [x1_imag',y1_imag'+ro1,tt1'];
xyimag1 = [xyimag1(1,:);xyimag1(5:end-20,:)];
xyimag2 = [x2_imag',y2_imag'+ro1,tt2'];
xyimag2 = [xyimag2(1,:);xyimag2(5:end-20,:)];
txtname1 = sprintf('g1_data%d.txt',n);
writematrix(xyimag1,txtname1);
txtname2 = sprintf('g2_data%d.txt',n);
writematrix(xyimag2,txtname2);
end























