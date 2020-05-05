% This script retrieves data from stored or online sources sends it back to
% sender
%
% Author: Paulin Kantue
% Date: April 2020
% Ver: 0.1

function data = retrieveData(opt)

folder = 'Covid2019_Archived_Data/';

if opt == 1 % Gauteng data
    prev_data = ['cov19_SA_' date]; 
    url = 'https://twitter.com/nicd_sa/';
    % url = 'https://www.worldometers.info/coronavirus/country/south-africa/';
    options=weboptions; 
    options.CertificateFilename=('');     
else
    prev_data = ['cov19_' date]; 
    options=weboptions; 
    url = 'https://www.worldometers.info/coronavirus/';
end

%% retrieve data depending depending on its location
if ~exist([folder prev_data '.txt'],'file')    
    % retrieve and store file
    data = webread(url,options);
    fid = fopen([folder prev_data '.txt'],'w');
    fprintf(fid,'%s',data);
    fclose(fid);
else
    fid = fopen([folder prev_data '.txt'],'r');
    data = fscanf(fid,'%s');
    fclose(fid);
end

end