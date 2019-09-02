function [D,M] = getD(obs,M)
%GETD computes diversity index
%  input:
%    obs - current observation (2 indices)
%    M - all until now observed cells
%  output:
%    D - diversity index
%    M - updated observed cells list

% Marcin Kuropatwiński (c)
% 
% 2019.06.13 
D = size(M,1);
I = binarySearchRows(M,D,obs);
if I == -1
    D = D + 1;
    M = [M;obs];
    M = sortrows(M);
end
end

