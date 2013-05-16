function [ output_args ] = knearest( ~ )
%KNEAREST K Nearest Neighbour based evaluation of Haar-Like features
%   Detailed explanation goes here

%for each file, depending on current directory, determine class/category
%and do:

dirlist = recursive_list_files('Z:\sounds\training\music','music');
dirlist2 = recursive_list_files('Z:\sounds\training\speech','speech');
testlist = recursive_list_files('Z:\sounds\test','test');

X = zeros(size(dirlist,1),2);
Y = cell(size(dirlist,1),1);
X2 = zeros(size(dirlist,1),2);
Y2 = cell(size(dirlist,1),1);


for i=1:size(dirlist,1)    
    [samples,hzcrr,lster,samplefreq] = recog(cell2mat(dirlist(i,2)),0);
    %fprintf('file num: %d, hzcrr: %0.4f, lster: %0.4f\n',i,hzcrr,lster);
    
    X(i,:) = [hzcrr,lster];
    %Y(i) = dirlist(i,1);   
    Y(i) = {'music'};
end

for i=1:size(dirlist2,1)    
    [samples,hzcrr,lster,samplefreq] = recog(cell2mat(dirlist2(i,2)),0);
    %fprintf('file num: %d, hzcrr: %0.4f, lster: %0.4f\n',i,hzcrr,lster);
    
    X2(i,:) = [hzcrr,lster];
    Y2(i) = {'speech'};    
end

X = [X ; X2];
Y = [Y ; Y2];

% for i=1:size(dirlist,1)    
%     [samples,hzcrr,lster,samplefreq] = recog(cell2mat(dirlist(i,2)),0);
%     fprintf('file num: %d, hzcrr: %0.4f, lster: %0.4f\n',i,hzcrr,lster);
%     
%     X(i,:) = [hzcrr,lster];
%     Y(i) = dirlist(i,1);    
% end

mdl = ClassificationKNN.fit(X,Y);
mdl.NumNeighbors = 3;

[testsamples, testhzcrr, testlster, samplefreq] = recog('Z:\sounds\test\2.wav',0);

testclass = predict(mdl, [testhzcrr, testlster])




end

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

