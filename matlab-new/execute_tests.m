training_set = 'D:\matlab\sounds3\training';
test_set = 'D:\matlab\sounds3\test';
output_file = 'D:\new2.xlsx';

filters = [2,4,6,8,10,12,14,16,18,20;
           2,4,6,10,12,16,18,20,0,0;
           2,6,10,12,16,20,0,0,0,0;
           2,8,14,20,0,0,0,0,0,0;
           2,20,0,0,0,0,0,0,0,0;
           6,16,0,0,0,0,0,0,0,0;
           10,12,0,0,0,0,0,0,0,0];
       
fprintf('Executing filter test, num of filters: 10\n');
performance_tests('10filters.TS2',output_file,'C',3,filters,training_set,test_set)

% fprintf('Executing filter test, num of filters: 6\n');
% performance_tests('8filters.TS2',output_file,'C',3,[2,4,6,10,12,16,18,20],training_set,test_set)
% 
% fprintf('Executing filter test, num of filters: 6\n');
% performance_tests('6filters.TS2',output_file,'C',3,[2,6,10,12,16,20],training_set,test_set)
% 
% fprintf('Executing filter test, num of filters: 4\n');
% performance_tests('4filters.TS2',output_file,'C',3,[2,8,14,20],training_set,test_set)
% 
% fprintf('Executing filter test, num of filters: 2\n');
% performance_tests('2filters.TS2',output_file,'C',3,[2,20],training_set,test_set)
% 
% fprintf('Executing filter test, num of filters: 2\n');
% performance_tests('2filters6.16.TS2',output_file,'C',3,[6,16],training_set,test_set)
% 
% fprintf('Executing filter test, num of filters: 2\n');
% performance_tests('2filters10.12.TS2',output_file,'C',3,[10,12],training_set,test_set)

