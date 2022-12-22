function [x1_cent,y1_cent,x2_cent,y2_cent,x1_imag,y1_imag,x2_imag,y2_imag] = ypokopi_calc_V2(xe,ye,ro1,ro2,xerror,yerror,thickness)
%% Ipologismos metatotopiseon kata ton paratiriti tou sinergazomenou
% Dy = sin(xerror)*thickness/2;
% Dx = sin(yerror)*thickness/2;
%% Ipologismos sinergazomenis katatomis
over = 10000; 
xetip_over = linspace(1*xe(1),1*xe(end),over);
yetip_over = linspace(1*ye(1),1*ye(end),over);
[x_imag,y_imag] = Contact2Profile(xetip_over*1,yetip_over*1,ro1,ro2);
[x1_cent,y1_cent,x2_cent,y2_cent] = Contact2Profile(1*xe,1*ye,ro1,ro2);
%metakinisi tou tis katatatomis_imag pano stin ketnriki (proeretika gia thnperiiptosi tis pou kano xrisi ekseligmenis)
th_cent = theta_contact(x1_cent,y1_cent,ro1);
%Euresi se gia kathe simio epafis tis kentrikis katatomis to antoistoixo apo thn sxetiki katatomi gia tin sygkekrimeni gonia epafis kai apothikeusi tou
x2_imag = zeros(1,length(th_cent));
y2_imag = zeros(1,length(th_cent));
x1_imag = zeros(1,length(th_cent));
y1_imag = zeros(1,length(th_cent));
for n = 1:length(th_cent)
[x_1imag_n,y_1imag_n,x_2imag_n,y_2imag_n] = find_th_eq(x_imag,y_imag,x1_cent(n),y1_cent(n),th_cent(n),xerror,yerror,ro1,ro2,thickness);
x1_imag(n) = x_1imag_n;
y1_imag(n) = y_1imag_n;
x2_imag(n) = x_2imag_n;
y2_imag(n) = y_2imag_n;
end

x1_imag = rmmissing(x1_imag);
y1_imag = rmmissing(y1_imag);
x2_imag = rmmissing(x2_imag);
y2_imag = rmmissing(y2_imag);
if length(x1_imag)~=length(y1_imag)||length(x2_imag)~=length(y2_imag)
    disp('error debug ypokopi_calc_V3')
end

end

function[x1_imag,y1_imag,x2_imag,y2_imag] = find_th_eq(x_imag,y_imag,x_real,y_real,dth,xerror,yerror,ro1,ro2,thickness)
%dth_tot = gonia tou eksetazomenou simeiou tis kanonikis katatomis
Dy = sin(xerror)*thickness/2;
Dx = sin(yerror)*thickness/2;
%% metafora stin gonia dth_tot olokliris tis katatomis
dth_in = dtheta_calc(0,0,x_real,y_real,ro1);
dth_tot = dth_in+dth;
[x_imag,y_imag] = Axis_Rot(x_imag,y_imag,dth_tot,0,-ro1);
[x_real,y_real] = Axis_Rot(x_real,y_real,dth_tot,0,-ro1);
%% proti diorthosi, metafora akson eksetia gonia sfalmatos prokimenou na kataskeuasti h sxetiki katatomi
dx = 1*(1-cos(yerror))*(x_real+0*Dx);
dy = 1*(1-cos(xerror))*(y_real+0*Dy);

%metatopisi tou ximag, yimag
x_imag = x_imag+Dx+dx;
y_imag = y_imag+Dy+dy;
PG = array_diff(y_imag,x_imag); %klisi se kathe simio tou profil

%metasximatismos tou ro pou vlepei o paratiritis
met1 = cos(1*xerror);
met2 = cos(1*yerror);
yy = y_real-(-ro1);
xx = x_real-0;
phi = atan(xx/yy);
met_tot = sqrt((met2*cos(phi))^2+(met1*sin(phi))^2);
dro1_sxet = -ro1*(1-met_tot); %thesi tou ano simiou tou sxetikou kiklou kilisis

%euresi tis euresi tou index antistixias
[min_dev,idx] = min(abs(-1./(-abs(PG))-y_imag./x_imag));
xeq = x_imag(idx);
yeq = y_imag(idx);

%% peristrofi tou antistixou simiou stin arxiki thesi

%metasximatismos sintagmenon gia troxo 1
[x1_imag,y1_imag] = Axis_Rot(x_real,y_real,-dth_tot,0,-ro1);
%metasximatismos sintetagmenon gia troxo 2
[x2_imag,y2_imag] = Axis_Rot(xeq,yeq,dth_tot*(ro1+dro1_sxet)/ro2,0,ro2);

%% elegxos yparksis simeiou apoklisi > 10^(-3) den theorite apodekti
if min_dev>1e-3
    x1_imag = nan;
    y1_imag = nan;
    x2_imag = nan;
    y2_imag = nan;
end

end


