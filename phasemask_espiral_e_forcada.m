clear all
close all
clc
x = -960 : 1 : 960; % a row-vector of points for the x-axis
y = -540 : 1 : 540; % a row-vector of points for the y-axis
[X,Y] = meshgrid(x,y); % create matrices for grids of X and Y
T_0 = 1;
alpha = 1; %amplitude of the phase modulation
l = 2 %topological charge absolute value
bigdelta = 150; %controls the period of the grating (fringe spacing)
%bigdelta = 100
G = bigdelta;
[M,N] = size(X)
for m = 1:M
for n = 1:N
q = atan2(Y(m,n),X(m,n));
r = sqrt(Y(m,n)^2 + X(m,n)^2);
T(m,n) = mod(q*l,2*pi); % spiral phase mask
%T(m,n) = T_0*exp(alpha*1i*cos(l/2*q-(2*pi*r*cos(q))/G)); % forked diffraction grating
%T(m,n) = 1;
end
end
%%
Treal = real(T);
gray_colormap = colormap('gray');

fig1 = figure(1);
figure(1);
fig1_colormap = 1 - gray_colormap;
pcolor(X,Y,Treal)
colormap(fig1_colormap)
shading interp %(removes the grid)
pos1 = get(gca, 'Position');
pos1(1) = 0.0;
pos1(2) = 0.0;
pos1(3) = 1;
pos1(4) = 1;
set(gca, 'Position', pos1)
axis('square')
axis('off')
set(gcf,'PaperUnits','points','PaperSize',[1,1],'PaperPosition',[0 0 1920 1080])
print('-dpng','-r72','p-mask')
print('-dbmp','-r72','p-mask')
%%
saveas(fig1,'ph.png')
