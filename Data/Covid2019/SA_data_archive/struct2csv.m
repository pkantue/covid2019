% This function is to write a struct into a csv file
%
% Notes: The idea with this file easy is have easy access to the same data
% is various formats.
%
% Date: May 2020
% Author: Paulin Kantue

function struct2csv(struct_data)

data = struct_data;
% interrogate if its a nested struct (cell) or a struct
if iscell(data)
    % compute the length of the cell array
    len = size(data);
    
    nfiles = length(data{1,1}.ColumnTag);
    
    for i = 1:nfiles
        
        fid = fopen([data{1,1}.ColumnTag{1,i} '.csv'],'w');
        
        % print column header [1,1]
        fprintf(fid,'province,');
        
        % print column header [1,2:n]
        for h = 1:len(1)
            fprintf(fid,'%s,',data{h,1}.date);
        end
        fprintf(fid,'\n');
        
        for j = 1:length(data{1,1}.table)
            for k = 0:len(1)
                
                if k == 0
                    fprintf(fid,'%s,',data{1,1}.RowTag{1,j});                
                elseif k == len(1)
                    fprintf(fid,'%s \n',num2str(data{k,1}.table(j,i)));             
                else
                    fprintf(fid,'%s,',num2str(data{k,1}.table(j,i)));
                end
            end
        end
        
        %}
        fclose(fid);
        
    end

end