% This script to create a script create a kml file for easy upload on Google maps
% This is for provinces
% 
% Date: May 2020
% Author: Paulin Kantue

clearvars;

%% load database file
data_A = readtable('Covid2019\SA_data_archive\Province_database.xlsx','sheet','Active');
data_DR = readtable('Covid2019\SA_data_archive\Province_database.xlsx','sheet','Death Rate');
data_RR = readtable('Covid2019\SA_data_archive\Province_database.xlsx','sheet','Recovery Rate');

%% write to KML file
% open file 
fid = fopen(['provinces_maps_' date '.kml'],'w');

% write preamble
fprintf(fid,'<?xml version="1.0" encoding="UTF-8"?>\n');
fprintf(fid,'<kml xmlns="http://www.opengis.net/kml/2.2">\n');
fprintf(fid,'  <Document>\n');
fprintf(fid,'    <name>Provinces: 08-05-2020</name>\n');
fprintf(fid,'    <Style id="icon-1653-0288D1-normal">\n');
fprintf(fid,'      <IconStyle>\n');
fprintf(fid,'        <color>ffd18802</color>\n');
fprintf(fid,'        <scale>1</scale>\n');
fprintf(fid,'        <Icon>\n');
fprintf(fid,'          <href>https://www.gstatic.com/mapspro/images/stock/503-wht-blank_maps.png</href>\n');
fprintf(fid,'        </Icon>\n');
fprintf(fid,'      </IconStyle>\n');
fprintf(fid,'      <LabelStyle>\n');
fprintf(fid,'        <scale>0</scale>\n');
fprintf(fid,'      </LabelStyle>\n');
fprintf(fid,'    </Style>\n');
fprintf(fid,'    <Style id="icon-1653-0288D1-highlight">\n');
fprintf(fid,'      <IconStyle>\n');
fprintf(fid,'        <color>ffd18802</color>\n');
fprintf(fid,'        <scale>1</scale>\n');
fprintf(fid,'        <Icon>\n');
fprintf(fid,'          <href>https://www.gstatic.com/mapspro/images/stock/503-wht-blank_maps.png</href>\n');
fprintf(fid,'        </Icon>\n');
fprintf(fid,'      </IconStyle>\n');
fprintf(fid,'      <LabelStyle>\n');
fprintf(fid,'        <scale>1</scale>\n');
fprintf(fid,'      </LabelStyle>\n');
fprintf(fid,'    </Style>\n');
fprintf(fid,'    <StyleMap id="icon-1653-0288D1">\n');
fprintf(fid,'      <Pair>\n');
fprintf(fid,'        <key>normal</key>\n');
fprintf(fid,'        <styleUrl>#icon-1653-0288D1-normal</styleUrl>\n');
fprintf(fid,'      </Pair>\n');
fprintf(fid,'      <Pair>\n');
fprintf(fid,'        <key>highlight</key>\n');
fprintf(fid,'        <styleUrl>#icon-1653-0288D1-highlight</styleUrl>\n');
fprintf(fid,'      </Pair>\n');
fprintf(fid,'    </StyleMap>\n');

nprov = 9;
province = {'Northern Cape','North West','Mpumalanga','Limpopo','Eastern Cape','Free State','KwaZulu-Natal','Western Cape','Gauteng'};
location = [21.8568586,-29.0466808,0;...
			25.2837585,-26.6638599,0;...
			30.1500153,-26.276849,0;...
			29.4179324,-23.4012946,0;...
			26.419389,-32.2968402,0;...
			26.7967849,-28.4541105,0;...
			30.8958242,-28.5305539,0;...
			21.8568586,-33.2277918,0;...
			28.1122679,-26.2707593,0];

% I still need to complete test whether the right output is coming out

for i=1:nprov
fprintf(fid,'    <Placemark>\n');
str1 = ['      <name>' province{1,i} '</name>\n'];
fprintf(fid,str1);
str2 = ['      <description><![CDATA[Active Cases: ' num2str(data_A{i+1,end}) '  https://bit.ly/3chyZlE'...
    '<br>Recovery Rate: ' num2str(data_RR{i+1,end},'%3.2f') '%%  https://bit.ly/2Wgw33d'...
    '<br>Death Rate: ' num2str(data_DR{i+1,end},'%3.2f') '%%  https://bit.ly/3baSuuF' '<br>]]></description>\n'];
fprintf(fid,str2);
fprintf(fid,'      <styleUrl>#icon-1653-0288D1</styleUrl>\n');
fprintf(fid,'      <Point>\n');
fprintf(fid,'        <coordinates>\n');
fprintf(fid,['          ' num2str(location(i,1),'%3.7f') ',' num2str(location(i,2),'%3.7f') ', 0 \n']);
fprintf(fid,'        </coordinates>\n');
fprintf(fid,'      </Point>\n');
fprintf(fid,'    </Placemark>\n');
end
fprintf(fid,'  </Document>\n');
fprintf(fid,'</kml>\n');

% close file
fclose(fid);