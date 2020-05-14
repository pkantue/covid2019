% This is a model canvas for the SEIR model
% This uses provincial data 
%
% Date: May 2020
% Author: Paulin Kantue

%% 
clearvars;
close all;

mu = 0; % equal birth and death rates
alpha = 1/2; % mean latent period for the disease
gamma = 1/27; % mean infectious period
beta = 0.08/1000; % contact rate over 1000

% initial simulation constants (western-cape)/1000
S = 881; % fraction of suceptible individual
E = 0;  % fraction of exposed individual
I = 88; % fraction of infected individual
R = 31; % fraction of recovered individual


%% perform simulation
sim_out = [];

ind = 1:400; % simulation days

for i = 1:length(ind)
    
    dS = mu - beta*S*I - mu*S;
    dE = beta*S*I - (mu + alpha)*E;
    dI = alpha*E - (mu + gamma)*I;
    
    sim_out = [sim_out; round(S) dS round(E) dE round(I) dI R];
    
    % integration 
    S = S + dS;
    E = E + dE;
    I = I + dI;
    
    R = 1000 - (S + E + I);
end