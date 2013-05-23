%% Sound Recognition script
% Some description text goes here
% And some more will go here. Great

%% Getting a list of training files
% This will get a list of all training files and properly classifies them
training_files_music = recursive_list_files('Z:\sounds\training\music','music');
training_files_speech = recursive_list_files('Z:\sounds\training\speech','speech');

X = zeros(size(training_files_music,1)*40,10);
Y = cell(size(training_files_music,1)*40,1);

X2 = zeros(size(training_files_music,1)*40,10);
Y2 = cell(size(training_files_music,1)*40,1);

%% Define filters
% Define some filters to use with Haar-Like recognition
Wfilters = [2,4,6,8,10,12,14,16,18,20];

%% Calculating Haar-Like filter values
% Per file the Haar-Like filter values calculated

for i=1:size(training_files_music,1)    
    [samples, info, framesize ] = read_wav_file(cell2mat(training_files_music(i,2)),40);
        
    Xmi = calculate_haar(samples,Wfilters);
    X((i-1)*size(Xmi,1)+1:(i)*size(Xmi,1),:) = Xmi;
    %X(i,:) = Xmi;
    %Y(i) = {'music'};
    Y((i-1)*size(Xmi,1)+1:(i)*size(Xmi,1)) = {'music'};
end

for i=1:size(training_files_speech,1)    
    [samples, info, framesize ] = read_wav_file(cell2mat(training_files_speech(i,2)),40);
        
    Xmi = calculate_haar(samples,Wfilters);
    X2((i-1)*size(Xmi,1)+1:(i)*size(Xmi,1),:) = Xmi;    
    %X2(i,:) = Xmi;
    %Y2(i) = {'speech'};   
    Y2((i-1)*size(Xmi,1)+1:(i)*size(Xmi,1)) = {'speech'};
end

X = [X ; X2];
Y = [Y ; Y2];

%% Creating the K-Nearest-Neighbours Model
% The Haar-Like features are now used to create a KNN Model, so sound
% samples can be tested against the model later on.

mdl = create_knn_model(X,Y,23);

%% Getting a list of test files
% Getting a list of test files now
test_files = recursive_list_files('Z:\sounds\test','test');

%% Test every testfile 1-by-1 against the model
% Classify according to what class most frames belong to
for i=1:size(test_files,1) 

    [samples, info, framesize ] = read_wav_file(cell2mat(test_files(i,2)),40);
    Xmtest = calculate_haar(samples,Wfilters);
    
    values = cell(1,size(Xmtest,1));
   
    for it = 1:size(Xmtest,1)
        %ivalue = predict(mdl,Xmtest(it,:));
        values(it) = predict(mdl,Xmtest(it,:));

        %fprintf('test %d: %s\n', it, cell2mat(predict(mdl, Xmtest(it,:)))); 
        %Xmtest(i,:)
    end

    testvalues = strcmp('music',values);

    fprintf('Test: %s, Music: %3.1f%%, Speech: %3.1f%%\n',info.Filename,(sum(testvalues)/size(testvalues,2))*100,((size(testvalues,2)-sum(testvalues))/size(testvalues,2))*100);

    
end
