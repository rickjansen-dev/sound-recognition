function [ result ] = performance_tests(sheet_name, excel_file, Xpos, Ypos, list_of_filters, trainingsset, testset)
    fprintf('filters:\n');
    for i=1:size(list_of_filters,1)

        fprintf('%d ',list_of_filters(i,:));
        fprintf('...\n');
        
        performance_vars = performance_test(trainingsset,testset,1,0,  list_of_filters(i,1:find(list_of_filters(i,:),1,'last')));   % big data set. music/speech differentiation. k = var

        sheetposition = [ Xpos num2str(i+Ypos)];
        
        

        status = xlswrite(excel_file,performance_vars,sheet_name,sheetposition);
        if status == 0
            error('failed to write to excel file.')
        end

    end
    
    fprintf('done.\n\n');

end

function [ result ] = performance_test(trainingsset, testset, k, no_printf, filters)
%% Sound Recognition script
% Some description text goes here
% And some more will go here. Great

result = zeros(1,25);

%% Getting a list of training files
% This will get a list of all training files and properly classifies them
training_files = recursive_list_files(trainingsset,'music');
%training_files_speech = recursive_list_files('D:\matlab\sounds\training\speech','speech');

%X2 = zeros(size(training_files_music,1)*40,10);
%Y2 = cell(size(training_files_music,1)*40,1);

%% Define filters
% Define some filters to use with Haar-Like recognition
%Wfilters = [2,4,6,8,10,12,14,16,18,20];
%Wfilters = [2,4,6,10,12,14,18,20];
%Wfilters = [2,6,10,14,18,20];
%Wfilters = [2,8,14,20];
%Wfilters = [2,20];
Wfilters = filters;

% Define X & Y Matrices
X = zeros(size(training_files,1)*40,length(Wfilters));
Y = cell(size(training_files,1)*40,1);

%% Calculating Haar-Like filter values
% Per file the Haar-Like filter values calculated

if no_printf == 0
    fprintf('training')
end
total_time = 0;
current_index = 1;
for i=1:size(training_files,1)        
    [samples, info, framesize ] = read_wav_file(cell2mat(training_files(i,2)),40);
    
    currentfiletic = tic;    
    Xmi = calculate_haar(samples,Wfilters);
    
    end_index = current_index + size(Xmi,1) - 1;
    %fprintf('id: %s\n',cell2mat(training_files(i,1)));
    %fprintf('current index: %d - %d\n',current_index, end_index);

    X(current_index:end_index,:) = Xmi;
    %X((i-1)*size(Xmi,1)+1:(i)*size(Xmi,1),:) = Xmi;    
    %X(i,:) = Xmi;
    %Y(i) = {'music'};
    %Y((i-1)*size(Xmi,1)+1:(i)*size(Xmi,1)) = {'music'};

    %fprintf('X-indexes: %d - %d\n',(i-1)*size(Xmi,1)+1,(i)*size(Xmi,1));
    %fprintf('Y-indexes: %d - %d\n',(i-1)*size(Xmi,1)+1,(i)*size(Xmi,1));
    %fprintf('New-indexes: %d - %d\n',current_index,end_index);
    %Y((i-1)*size(Xmi,1)+1:(i)*size(Xmi,1)) = training_files(i,1);
    Y(current_index:end_index) = training_files(i,1);
    
    current_index = end_index + 1;
    total_time = total_time + toc(currentfiletic);
    if no_printf == 0
        fprintf('.');
    end
end

result(1) = total_time;
result(2) = size(training_files,1);

if no_printf == 0
    fprintf('done\n\naverage time per file: %2.6f',total_time/size(training_files,1));
end
% fprintf('speech');
% 
% for i=1:size(training_files_speech,1)    
%     [samples, info, framesize ] = read_wav_file(cell2mat(training_files_speech(i,2)),40);
%         
%     Xmi = calculate_haar(samples,Wfilters);
%     X2((i-1)*size(Xmi,1)+1:(i)*size(Xmi,1),:) = Xmi;    
%     %X2(i,:) = Xmi;
%     %Y2(i) = {'speech'};   
%     Y2((i-1)*size(Xmi,1)+1:(i)*size(Xmi,1)) = {'speech'};
%     %Y2((i-1)*size(Xmi,1)+1:(i)*size(Xmi,1)) = {'speech'};
%     fprintf('.');
% end

if no_printf == 0
    fprintf('done\n\n');
end


%Y1 = cell(size(X,1),1);
%Y2 = cell(size(X2,1),1);

%Y1(:) = {'music'};
%Y2(:) = {'speech'};

%X = [X ; X2];
%Y = [Y1 ; Y2];



%testvalues = sum(strcmp('music',Y));
%testvalues2 = sum(strcmp('speech',Y));

%fprintf('size X: %dx%d, size Y: %dx%d\n size testvalue1:%d, size testvalue2: %d\n\n',size(X,1),size(X,2),size(Y,1),size(Y,2),testvalues,testvalues2);

%% Creating the K-Nearest-Neighbours Model
% The Haar-Like features are now used to create a KNN Model, so sound
% samples can be tested against the model later on.
if no_printf == 0
    fprintf('generating model...');
end
mdl_start_time = tic;
mdl = create_knn_model(X,Y,1);
result(3) = toc(mdl_start_time);
s = whos('mdl');
result(4) = s.bytes;
if no_printf == 0
    fprintf('done\n\n');
end

%% Getting a list of test files
% Getting a list of test files now
test_files = recursive_list_files(testset,'test');

%% Test every testfile 1-by-1 against the model
% Classify according to what class most frames belong to
for i=1:size(test_files,1)     
    [samples, info, framesize ] = read_wav_file(cell2mat(test_files(i,2)),40);
    [lster, ste] = calculate_ste(samples);
    
    %ste(find(ste>500000000))
    
    testfiletic = tic;
    Xmtest = calculate_haar(samples,Wfilters);    
    
    values = cell(1,size(Xmtest,1));
   
    for it = 1:size(Xmtest,1)
        %ivalue = predict(mdl,Xmtest(it,:));
        values(it) = predict(mdl,Xmtest(it,:));

        %fprintf('test %d: %s\n', it, cell2mat(predict(mdl, Xmtest(it,:)))); 
        %Xmtest(i,:)
    end
    
    testfiletoc = toc(testfiletic);
    result(5+i) = testfiletoc;

    unique_items = unique(values);
    if no_printf == 0
        fprintf('Test: %s',info.Filename);
    end
    
    %size(test_files,1)
    %test_files(i,1)
    
    correctness = sum(strcmp(test_files(i,1),values))/size(values,2);
    
    result(5+size(test_files,1)+i) = correctness;
    
    
    for j=1:length(unique_items)
        testvalues = strcmp(unique_items(j),values);
        if no_printf == 0
            fprintf(' - %s: %3.1f%%',cell2mat(unique_items(j)),(sum(testvalues)/size(testvalues,2))*100);
        end
    end
    
    if no_printf == 0
        fprintf(' - time: %2.6f\n',testfiletoc);
    end
    
    

    %fprintf('Test: %s, Music: %3.1f%%, Speech: %3.1f%%\n',info.Filename,(sum(testvalues)/size(testvalues,2))*100,((size(testvalues,2)-sum(testvalues))/size(testvalues,2))*100);

    
end

result(5) = k;

%result = 5;

end
