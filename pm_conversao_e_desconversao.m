close all
clear all
clc


x = -480 : 1 : 480; % a row-vector of points for the x-axis
y = -540 : 1 : 540; % a row-vector of points for the y-axis
[X,Y] = meshgrid(x,y); % create matrices for grids of X and Y
T_0=1;
alpha=1;
l=1;
bigdelta=150;
G=bigdelta;
[M,N]=size(X)
for m = 1:M
for n = 1:N
q = atan2(Y(m,n),X(m,n));
r = sqrt(Y(m,n)^2 + X(m,n)^2);
T(m,n) =mod(q*l,2*pi); % spiral phase mask
%T(m,n) = T_0*exp(alpha*1i*cos(l/2*q-(2*pi*r*cos(q))/G)); % forked diffraction grating
%T(m,n) = 1;
end
end

Treal=real(T);


gray_colormap = colormap('gray');


% x=1:1:1920;
% y=1:1:1080;
% [C,D]=meshgrid(x,y);
% 
% for b=1:1:1080
%     for a=1:1:960
%         B(b,a)=Treal(b,a); 
%         B(b,1921-a)=Treal(b,a);
%     end
% end
% 
% Breal=real(B);
% 
% fig1 = figure(1);
% figure(1);
% fig1_colormap = gray_colormap;
% pcolor(C,D,Breal)
% colormap(fig1_colormap)
% shading interp
% pos2 = get(gca, 'Position');
% pos2(1) = 0.0;
% pos2(2) = 0.0;
% pos2(3) = 1;
% pos2(4) = 1;
% set(gca, 'Position', pos2)
% 
% saveas(fig1,'ph.png')


x=1:1:1920;
y=1:1:1080;
[C,D]=meshgrid(x,y);

for b=1:1:1080
    for a=1:1:960
        B(b,a)=Treal(b,a); 
        B(b,1921-a)=Treal(b,a);
    end
end

Breal=real(B);

fig1 = figure(1);
figure(1);
fig1_colormap = gray_colormap;
pcolor(C,D,Breal)
colormap(fig1_colormap)
shading interp
pos2 = get(gca, 'Position');
pos2(1) = 0.0;
pos2(2) = 0.0;
pos2(3) = 1;
pos2(4) = 1;
set(gca, 'Position', pos2)

saveas(fig1,'ph.png')
