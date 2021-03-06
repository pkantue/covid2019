% This is a model canvas for the SEIR model
% This uses provincial data 
% References: 
% https://sites.me.ucsb.edu/~moehlis/APC514/tutorials/tutorial_seasonal/node4.html
% https://wwwnc.cdc.gov/eid/article/26/7/20-1595_article
%
% Date: May 2020
% Author: Paulin Kantue

%% 
clearvars;
close all;

mu = 0; % equal birth and death rates
alpha = 1/2; % mean latent period for the disease
gamma = 1/21; % mean infectious period
beta = 0.08/1000; % contact rate over 1000

% initial simulation constants (western-cape)/1000
I = 55; % fraction of infected individuals
E = (mu + gamma).*I./alpha;  % fraction of exposed individuals
R = 31; % fraction of recovered individuals
S = 1000 - (I + E + R); % fraction of suceptible individuals

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