function [gm,axes,prb] = random_gmm(numComponents, dimension, level)
%RANDOM_GMM generate gmm with random means and covariance matrices
%   numComponents - number of components
%   dimension - dimension of the underlying space
%   level - gm truncation level
% 
% note:
% this script requires the matlab statistics and machine learning toolbox

% Marcin Kuropatwiński (c)
%
% 2019.07.18

sigma = randn(dimension,dimension,numComponents);

for i = 1:numComponents
    sigma(:,:,i) = sigma(:,:,i)*sigma(:,:,i)';
    [V, D] = eig(sigma(:,:,i));
    D = diag(D);
    D(D < max(D)*0.1) = max(D)*0.1;
    sigma(:,:,i) = V'*diag(D)*V;
end

mu = randn(numComponents,dimension);

gm = gmdistribution(mu,sigma);

Z_ = random(gm,10000);
s = std(Z_);
m = mean(Z_);
x = linspace(-6*s(1)+m(1),6*s(1)+m(1),300);
y = linspace(-6*s(2)+m(2),6*s(2)+m(2),300);
axes = [min(x), max(x), min(y), max(y)];

M = 0;
R = 0;
Z_ = random(gm,100000);
for i = 1:100000
    p = pdf(gm,Z_(i,:));
    if p > level
        R = R + 1;
    end
    M = M + 1;
end
prb = R/M;

