function [ model ] = create_knn_model( haar, haar_class, neighbours )
%CREATE_KNN_MODEL Creates a KNN Model from a Matrix of Haar-Like features
%   Detailed explanation goes here

model = ClassificationKNN.fit(haar,haar_class);
model.NumNeighbors = neighbours;

end

function [ result ] = test_haar_against_model( haar, model)
%TEST_HAAR_AGAINST_MODEL Tests given Haar-Like filter values
%   Tests the given Haar-Like features values against the supplied KNN
%   model to predict the type of sound.

result = 0;

end

