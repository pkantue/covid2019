% This is the SEIR model function
% This uses provincial data as inputs 
% 
% References: 
% https://sites.me.ucsb.edu/~moehlis/APC514/tutorials/tutorial_seasonal/node4.html
% https://wwwnc.cdc.gov/eid/article/26/7/20-1595_article
%
% Date: May 2020
% Author: Paulin Kantue
function [sim_out] = SEIR_model_func(T,R,I,beta)
%%
rng('default');

ind = 1:400; % simulation days

%% compute more realistic randomized incubation/communicable period
a = 11.5; % average incubation period then isolation/quarantine (symptomatic) - 85% of cases
b = 27; % maximum communicable period for asymptomatic cases - 15% of cases.
r = a + (b-a).*rand(length(ind),length(T));
gamma_data = 1./abs(r');

gamma = gamma_data(:,1); % mean infectious period
%%
mu = 0; % equal birth and death rates
alpha = 1/2; % mean latent period for the disease
beta = beta/1000; % contact rate over 1000

% initial simulation constants (western-cape)/1000
I = ((I.*1000)./T); % fraction of infected individuals
R = ((R.*1000)./T); % fraction of recovered individuals
E = (mu + gamma).*I./alpha;  % fraction of exposed individuals
S = 1000 - (I + E + R); % fraction of suceptible individuals

%% perform simulation
sim_out = [];

count = 1;
for i = 1:length(ind)
    
    gamma = gamma_data(:,i); % mean infectious period
    
    dS = mu - beta.*S.*I - mu.*S;
    dE = beta.*S.*I - (mu + alpha).*E;
    dI = alpha.*E - (mu + gamma).*I;
    
    % save every 5th day
    if ~mod(i,5)
        sim_out{1,count} = [round((S).*T./1000) dS round((E).*T./1000)...
            dE round((I).*T./1000) dI round(R.*T./1000)];
        count = count + 1;
    end
    
    % integration 
    S = S + dS;
    E = E + dE;
    I = I + dI;
    
    R = 1000 - (S + E + I);
end