function [ output_args ] = haar( filename )
%HAAR calculates HAAR-like feature value vectors from a audio sample

%define filters to use
Wfilters = [2,4,6,8,10,12,14,16,18,20];
alpha = 1;
frames = 40;
framesize = samples/frames;

fprintf('Selected frame size: %d', framesize);

[samples, hzcrr, lster] = recog(filename,0);

% IS array is created with size of sample-array.
% in C implementation, one would most likely calculate just the values for
% the current frame to save memory (1-frame's worth of 32bit ints instead
% of a complete 1sec sample, which would consume 32KB - the Arduino Due 
% has 96 in total...)
IS = zeros(size(samples,1));
Icurrent = 0;

for i=1:size(samples,1)
   Icurrent = Icurrent + samples(i);
   IS(i) = Icurrent;
end

% for each frame, do:
    % -calc IS values=C only-
    % for each filter, do:
        %for each 'N'
            % filtertotal xm += filtervalue;

end

