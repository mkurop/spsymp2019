function [v] = a2vertices(scale)
% function returns vertices of the fundamental region of the A2 lattice
%   input: scale - linear scale for the fundamental region (the smaller
%   scale the lower area of the fundamental region, the area scales
%   proportionally to scale^2)
%   output: v - six vertices arranged in rows

% Marcin Kuropatwiński (c)
%
% 2019.06.12 

v1 = mean([-1,0;-.5,sqrt(3)/2;0,0]);
v2 = mean([1/2,sqrt(3)/2;-1/2,sqrt(3)/2;0,0]);
v3 = mean([1,0;1/2,sqrt(3)/2;0,0]);
v4 = mean([1,0;1/2,-sqrt(3)/2;0,0]);
v5 = mean([-1/2,-sqrt(3)/2;1/2,-sqrt(3)/2;0,0]);
v6 = mean([-1,0;-1/2,-sqrt(3)/2;0,0]);
v = [v1;v2;v3;v4;v5;v6]*scale;
end

