% This script is load csv files of accummulated files and save to
% multi-sheet Excel document for visualization
%
% Date: May 2020
% Author: Paulin Kantue

clearvars;

%% load datasets
dat_C = csvread('Accumulated Cases.csv',1,1);
tab_C = readtable('Accumulated Cases.csv');
dat_D = csvread('Accumulated Deaths.csv',1,1);
tab_D = readtable('Accumulated Deaths.csv');
dat_R = csvread('Accumulated Recoveries.csv',1,1);
tab_R = readtable('Accumulated Recoveries.csv');
    
%% compute active cases
dat_A = dat_C - dat_D - dat_R;

%% compute closed cases
dat_CL = dat_C - dat_A;

%% recovery rate
dat_RR = 100.*dat_R./dat_CL;
ind = find(isnan(dat_DR) == 1);
dat_RR(ind) = 100;

%% death rate
dat_DR = 100.*dat_D./dat_CL;
ind = find(isnan(dat_DR) == 1);
dat_DR(ind) = 0;