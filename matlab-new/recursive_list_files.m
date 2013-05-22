function [ list_files ] = recursive_list_files(directory,directoryname)
% RECURSIVE_LIST_FILES generates a list of files
%   Recursively searches for files in current directory and it's
%   subdirectories. Uses the parent folder name as category identifier.

dirlist = dir(directory);

list_files = {};

for i=1:size(dirlist)
   current_file = dirlist(i,1);
   current_filename = sprintf('%s\\%s',directory,current_file.name);
   if (~strcmp(current_file.name,'.') && ~strcmp(current_file.name,'..'))
       if (current_file.isdir == 1)
          % it is a dir
          list_files2 = recursive_list_files(current_filename, current_file.name);
          list_files = [list_files;list_files2];

       else
          % it is a file
          list_files(end+1,:) = {directoryname current_filename};  
       end
   end
end

%list_files = {'category' 'filename';'category 2' 'otherfile'};

end



