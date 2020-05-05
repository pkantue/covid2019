% This script is to clean-up the data set such that it has consistant data
% and data fields.
%
% Author: Paulin Kantue
% Date: April 2020
% Ver: 0.2

clearvars;

UPDATE_COLUMNS = 0;
LIST_UNIDENT_DEATH = 0;
LIST_RECOVER = 0;
SAVE_DATA = 0;
UPDATE_DISTRICT = 1;

%%
load('Covid2019_Archived_Data/covid19SA.mat');

%% update the columns with latest fields
if UPDATE_COLUMNS
    for i = 1:size(data,1)
        len = size(data{i,1,1}.table,2);
        
        % update the Column tags with the latest one
        data{i,1,1}.ColumnTag = data{30,1,1}.ColumnTag;
        
        % update the table with zeros based on additional column tags
        if len < size(data{30,1,1}.ColumnTag,2)
            data{i,1,1}.table(:,(len+1 : size(data{30,1,1}.ColumnTag,2))) = 0;
        end
    end
end

%% find death tally under 'Unidentified'
if LIST_UNIDENT_DEATH
    for i = 1:size(data,1)
        ind(i) = data{i,1,1}.table(1,2) > 0;
        if ind(i) > 0 display(data{i,1,1}.date); end
    end
    
    % list table death summation up to user-defined date
    user_date = '25-Apr-2020';
    
    table = [];
    for i = 1:size(data,1)
        
        % collect table data
        table = [table data{i,1,1}.table(:,2)];
        if strfind(data{i,1,1}.date,user_date)
            break;
        end
    end
end

%% confirm the recoveries
if LIST_RECOVER
    table = [];
    for i = 1:size(data,1)
        table = [table data{i,1,1}.table(:,3)];
    end
end

%% develop district and sub-district structure

if UPDATE_DISTRICT
    
    s.level = 'District';
    s.RowTag = {'Johannesburg','Tshwane','Ekurhuleni','Sedibeng','Westrand','Unallocated'};
    s.ColumnTag = {'Accumulated Cases', 'Accumulated Recoveries'};
    s.date = data{1,1,1}.date;
    s.table = zeros(length(s.RowTag),length(s.ColumnTag));
    
    ss.level = 'Sub-District';
    ss.RowTag = {...
        'Johannesburg-A',...
        'Johannesburg-B',...
        'Johannesburg-C',...
        'Johannesburg-D',...
        'Johannesburg-E',...
        'Johannesburg-F',...
        'Johannesburg-G',...
        'Johannesburg-Unallocated',...
        'Tshwane-1',...
        'Tshwane-2',...
        'Tshwane-3',...
        'Tshwane-4',...
        'Tshwane-5',...
        'Tshwane-6',...
        'Tshwane-7',...
        'Tshwane-Unallocated',...
        'Ekurhuleni-East',...
        'Ekurhuleni-North',...
        'Ekurhuleni-South',...
        'Ekurhuleni-Unallocated',...
        'Sedibeng-Lesedi',...
        'Sedibeng-Emfuleni',...
        'Sedibeng-Midvaal',...
        'Sedibeng-Unallocated',...
        'Westrand-Mogale',...
        'Westrand-Rand West',...
        'Westrand-Merafong',...
        'Westrand-Unallocated'};
    
    ss.ColumnTag = {'Accumulated Cases'};
    ss.date = data{1,1,1}.date;
    ss.table = zeros(length(ss.RowTag),length(ss.ColumnTag));
    
    for i = 1:size(data,1)
        data{i,2,1} = s;
        data{i,2,2} = ss;
    end
    
end

%% save data
if SAVE_DATA
    save('Covid2019_Archived_Data/covid19SA.mat','data');
end