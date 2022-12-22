clear

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
xerror = 10*pi/180;
yerror = 5*pi/180;
tgear = 4;
[x1_cent,y1_cent,x2_cent,y2_cent,x1_imag,y1_imag,x2_imag,y2_imag] = ypokopi_calc_V3(xcc,ycc,ro1,ro2,xerror,yerror,tgear);
%% for plots
phi = linspace(0,2*pi,200);
x_cycle1 = ro1*cos(phi);
y_cycle1 = ro1*sin(phi);
x_cycle2 = ro2*cos(phi);
y_cycle2 = ro2*sin(phi)+ro1+ro2;
%% plots
figure(3)
axis equal
plot(x_cycle1,y_cycle1,'-.g')
hold on
plot(x_cycle2,y_cycle2,'-.g')
plot(x1_cent,y1_cent+ro1,'.r')
plot(x2_cent,y2_cent+ro1,'k')
plot(x1_imag,y1_imag+ro1,'b')
plot(x2_imag,y2_imag+ro1,'.m','LineWidth',2)
plot(xcc,ycc+ro1,'y')
hold off
axis equal
legend('initial cycle 1','initial cycle 2','center profile 1','center profile 2','tip profile 1','tip profile 2')
xlim([-5,5])
ylim([-5+ro1,5+ro1])

%%                                                                                                                                                                                                                                                                                    
xy1_cent = [x1_cent',y1_cent'];
xy2_cent = [x2_cent',y2_cent'];
xy1_imag = [x1_imag',y1_imag'];
xy2_imag = [x2_imag',y2_imag'];


