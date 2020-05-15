% This script is to execute and process SEIR data for upload on a Googgle
% Spreadsheet
%
% Date: May 2020
% Author: Paulin Kantue

clearvars;
close all;

load('SEIR_input_data_14-05-2020');
T = data(:,1);
R = data(:,2);
I = data(:,3);
beta = data(:,4);

output = SEIR_model_func(T,R,I,beta);

%% format for Excel spreadsheet
active_cases = [I];
for i =1:length(output)
    active_cases = [active_cases output{1,i}(:,5)];
end