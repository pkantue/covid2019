% This script is to execute a rolling apex of active cases
%
% Date: May 2020
% Author: Paulin Kantue

clearvars;
close all;

data_T = readtable('..\Data\Covid2019\SA_data_archive\Province_database.xlsx','sheet','Testing');
data_I = readtable('..\Data\Covid2019\SA_data_archive\Province_database.xlsx','sheet','Active');
data_R = readtable('..\Data\Covid2019\SA_data_archive\Province_database.xlsx','sheet','Recoveries');
data_b = readtable('..\Data\Covid2019\SA_data_archive\Province_database.xlsx','sheet','Infection Rate');

%% compute active cases per 100,000
Ib = data_I{3:11,end-1};
popu = data_b{15:23,2};
res = 100000.*Ib./popu;

%% compute number rolling active cases peak
numDays = 14; % compute the peak of active cases from the last two weeks

for k = 1:numDays
    
    T = data_T{2:10,end-(numDays+1-k)}; % latest tested cases
    R = data_R{2:10,end-(numDays+1-k)}; % latest recovered cases
    I = data_I{3:11,end-(numDays+1-k)}; % latest active/infected cases
    beta = data_b{3:11,end-(numDays+1-k)}; % latest rate of infection
    
    %% get the latest date with data table
    date_str = split((data_b.Properties.VariableDescriptions{1,end-(numDays+1-k)}),'Original column heading: ');
    date_str = split(date_str{2,1},'''');
    date_str = date_str{2,1};
    cur_date = datetime(date_str);
    
    %% run SEIR simulation
    output = SEIR_model_func(T,R,I,beta);
    
    %% format for Excel spreadsheet
    active_cases = [I];
    for i =1:length(output)
        active_cases = [active_cases output{1,i}(:,5)];
    end
    
    %% get dates associated with output data
    for i =1:length(output)
        cur_date(1,i+1) = dateshift(cur_date(1,i),'start','day',5);
    end
    
    %% get max value and date of apex
    [val(k),ind] = max(sum(active_cases));
    val_date(1,k) = cur_date(1,ind);
    temp = sum(active_cases);
    hist_val(k) = temp(1);
    hist_date(k) = cur_date(1,1);
end

%% compute the difference in time current vs predicted
diff_date = caldays(between(hist_date,val_date,'days'));

%% output to Excel for graphing
print_out = [val; hist_val];