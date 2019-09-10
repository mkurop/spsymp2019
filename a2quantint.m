function [u, uint] = a2quantint(p, scale)
%A2QUANT quantization with the A2 (hexagonal) lattice
% input:
%   p - point to be quantized
%   scale - linear scale to be applied during quantization (adjusting
%   linear dimensions of the quantizers cells)
% output:
%   u - lattice point coordinates (closest to p)
%   uint - integer lattice coordinates

% Marcin Kuropatwiński (c)
% 
% 2019.06.17

p = p/scale;

M = [1,0,-1;1/sqrt(3),-2/sqrt(3),1/sqrt(3)];

x = p(:)'*M;

xprim = round(x);

Delta = sum(xprim); % deficiency

delta = x - xprim;

[~,I] = sort(delta);

if Delta == 0
 % nop
elseif Delta < 0
    xprim(I(end)) = xprim(I(end)) + 1;
else
    xprim(I(1)) = xprim(I(1)) - 1;
end

u = xprim * .5 * M.';

if sum(abs(u - round(u))) >= 1e-16
    uint = round(u ./[.5,sqrt(3)/2]);
else
    uint = u;
end
u = scale*u;
end

