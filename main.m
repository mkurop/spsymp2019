% This is the main script showing the usage of techniques introduced in the
% paper for the IEEE SPSympo'19 entitled "Estimation of Quantities Related 
% to the Multinomial Distribution with Unknown Number of Categories"
% 
% It ilustrates the estimation of the region of high probability and the
% usage of the progress bar mentioned in the paper.

% Marcin Kuropatwinski (c)
%
% 2019.09.02

% input settings
clc
close all
% the equiprobability level for truncation of the test GMM, 
level = 0.0001; 

% scale for the lattice, larger scale means higher generalization and
% reduced precision
scale = 1.3;

% compute vertices of the A2 lattice fundamental region at the given scale
v = a2vertices(scale);

% alpha - the experimental exponent for the generalization coefficient
alpha = 1.4;

% number of samples used in the experiment (need to be high to be sure it
% suffices for estimation of the region of high probability)
num_samples = 1000000;

% generation of the three component, two dimensional random GMM object
% and estimate the high probability region probability PrB
[gm, axes, PrB] = random_gmm(3,2,level);
PrA = 1 - PrB;

% plot the region of high probability
figure(1)
clf
plot_gm(gm,1,level);
grid on
hold on
axis(axes)
daspect([1 1 1])
drawnow

% generate random samples from the random GMM object
RS = single(random(gm,num_samples));

% memory for the lattice regions centers
U = zeros(size(RS,1),2);

% placeholder for the list of, unique, integer lattice coordinates
M = [];

% starting value for the diversity index
Zprev = 0;

% setup the progressbar
h = waitbar(0,'Please wait ...');
start = 0; % flag indicating readiness to display the progressbar

% region estimation loop

for i = 1:size(RS,1) % iterate over random sample
    
    p = RS(i,:); % get the sample point
    
    [U(i,:), uint] = a2quantint(p,scale); % quantize the point
    
    [Z, M] = getD(uint,M); % get current value of the diversity index 
    
    vshifted = v + U(i,:); % shift the vertices of the fundamental region
                           % according to quantized cell center U
                           
    sh = polyshape(vshifted(:,1),vshifted(:,2)); % form the polygon object
    
    if Z > Zprev % plot new area only at increase of the diversity index
        
        figure(1)
        
        plot(sh, 'EdgeColor', 'none', 'FaceColor', [0.5,0.5,0.5]) % actualy plots the area
        hold on;
        
        N = i/Z; % current generalization coefficient
        
        Kmmse = (Z*N - 1)/(N -(2*N/i) - 1); % compute the K, number of bins
        
        Meta = Kmmse*PrA^(-1/alpha); % compute the target number of samples
        
        start = 1; % set the progressbar flag to true
        
    end
    
    if start
        waitbar(i/Meta,h)
    end
    
    if mod(i,100) == 0 % plot the figure each hundred samples
        daspect([1 1 1])
        drawnow
    end
    
    Zprev = Z; % update previous diversity index

    if(1/(N)^alpha < (1-PrB)) % ending condition
        break
    end

end





