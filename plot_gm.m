function [] = plot_gm(gm,fig_num,level)
%PLOT_GM plots given gm equiprobability countour (the truncation 
%probability density is given by the level input variable
%   gm - gaussian mixture object
%   fig_num - the figure
%   level - the equiprobability countour level
% note:
% requires the matlab statistics and machine learning toolbox

% Marcin Kuropatwiński (c)
%
% 2019.09.02

Z_ = random(gm,10000);
s = std(Z_);
m = mean(Z_);
x = linspace(-6*s(1)+m(1),6*s(1)+m(1),300);
y = linspace(-6*s(2)+m(2),6*s(2)+m(2),300);
[X,Y] = meshgrid(x,y);
Z = zeros(length(x),length(y));

for i = 1:length(x)
    for j = 1:length(y)
        Z(i,j) = pdf(gm,[x(i),y(j)]);
    end
end
figure(fig_num);
contour(X,Y,Z',[level level], 'black','LineWidth',4)
daspect([1 1 1])
end

