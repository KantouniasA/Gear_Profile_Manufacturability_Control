function [df_dx,ddf_ddx] = array_diff(f,xc)

%% Proti paragogos
%proso paragogisi
df_dx = zeros(1,length(xc));
dx12 = xc(2)-xc(1);
dx13 = xc(3)-xc(1);
k = -(dx12 + dx13)/(dx12*dx13);
l = -dx13/(dx12*(dx12 - dx13));
m = dx12/(- dx13^2 + dx12*dx13);
df_dx(1) = k*f(1)+l*f(2)+m*f(3);

%mesi paragogisi
for n = 2:length(xc)-1
    dx12 = xc(n)-xc(n-1);
    dx23 = xc(n+1)-xc(n);
    k = -dx23/(dx12*(dx12 + dx23));
    l = -(dx12 - dx23)/(dx12*dx23);
    m = dx12/(dx23^2 + dx12*dx23);
    df_dx(n) = k*f(n-1)+l*f(n)+m*f(n+1);
end
%piso paragogisi
dx23 = xc(end)-xc(end-1);
dx13 = xc(end)-xc(end-2);
k = dx23/(dx13*(dx13 - dx23));
l = -dx13/(dx23*(dx13 - dx23));
m = (dx13 + dx23)/(dx13*dx23);
df_dx(end) = k*f(end-2)+l*f(end-1)+m*f(end) ; 

%% Deuteri paragogos
ddf_ddx = zeros(1,length(xc));
% proso paragogisi
dx12 = xc(2)-xc(1);
dx13 = xc(3)-xc(1);
k = 2/(dx12*dx13);
l = 2/(dx12*(dx12 - dx13));
m = -2/(- dx13^2 + dx12*dx13);
ddf_ddx(1) = k*f(1)+l*f(2)+m*f(3);
%mesi paragogisi
for n = 2:length(xc)-1
    dx12 = xc(n)-xc(n-1);
    dx23 = xc(n+1)-xc(n);
    k = 2/(dx12*(dx12 + dx23));
    l = -2/(dx12*dx23);
    m = 2/(dx23^2 + dx12*dx23);
    ddf_ddx(n) = k*f(n-1)+l*f(n)+m*f(n+1);
end
%piso paragogisi
dx23 = xc(end)-xc(end-1);
dx13 = xc(end)-xc(end-2);
k = 2/(dx13*(dx13 - dx23));
l = -2/(dx23*(dx13 - dx23));
m = 2/(dx13*dx23);
ddf_ddx(end) = k*f(end-2)+l*f(end-1)+m*f(end); 
end
