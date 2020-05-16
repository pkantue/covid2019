% This script is to execute and process SEIR data for upload on a Googgle
% Spreadsheet
%
% Date: May 2020
% Author: Paulin Kantue

clearvars;
close all;

data_T = readtable('..\Data\Covid2019\SA_data_archive\Province_database.xlsx','sheet','Testing');
data_I = readtable('..\Data\Covid2019\SA_data_archive\Province_database.xlsx','sheet','Active');
data_R = readtable('..\Data\Covid2019\SA_data_archive\Province_database.xlsx','sheet','Recoveries');
data_b = readtable('..\Data\Covid2019\SA_data_archive\Province_database.xlsx','sheet','Infection Rate');
%%

T = data_T{2:10,end-1}; % latest tested cases
R = data_R{2:10,end-1}; % latest recovered cases
I = data_I{3:11,end-1}; % latest active/infected cases
beta = data_b{3:11,end-1}; % latest rate of infection

%% run SEIR simulation
output = SEIR_model_func(T,R,I,beta);

%% format for Excel spreadsheet
active_cases = [I];
for i =1:length(output)
    active_cases = [active_cases output{1,i}(:,5)];
end