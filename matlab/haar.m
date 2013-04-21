function [ output_args ] = haar( filename )
%HAAR calculates HAAR-like feature value vectors from a audio sample

%define filters to use
Wfilters = [2,4,6,8,10,12,14,16,18,20];
alpha = 1;
frames = 40;
framesize = 8000/frames;
Wshift = 0;

fprintf('Selected frame size: %d', framesize);

[samples, hzcrr, lster] = recog(filename,0);

% IS array is created with size of sample-array.
% in C implementation, one would most likely calculate just the values for
% the current frame to save memory (1-frame's worth of 32bit ints instead
% of a complete 1sec sample, which would consume 32KB - the Arduino Due 
% has 96 in total...)
global IS;
Icurrent = 0;
IS = zeros(size(samples,2));

%samples(1,2)

for i=1:size(samples,2)
    Icurrent = Icurrent + samples(1,i);
   IS(i) = Icurrent;
end

xm = zeros(frames);
t=0;

%for j=1:frames
for j=1:2    
   xmcurrent = zeros(size(Wfilters));
   for wf=1:length(Wfilters)
       Wshift = alpha * Wfilters(wf);
       xmcurrent_filter = 0;
       for n=1:((framesize-Wfilters(wf))/Wshift + 1)
           t = j*framesize + n;
           %fprintf(' OneFilterValue: %d - %d - %d', IS(t+Wfilters(wf)),2 * IS(t+Wfilters(wf)/2),IS(t));
           onefiltervalue = IS(t+Wfilters(wf)) - 2 * IS(t+Wfilters(wf)/2) + IS(t);
           xmcurrent_filter = xmcurrent_filter + onefiltervalue;
       end
       %fprintf('filter wf = %d, value: %d\n',Wfilters(wf),xmcurrent_filter);
       xmcurrent(wf) = xmcurrent_filter;
   end
   fprintf('frame %d\n', j);
   xmcurrent
   %xm(j) = xmcurrent;
end
% for each frame, do:
    % -calc IS values=C only-
    % for each filter, do:
        %for each 'N'
            % filtertotal xm += filtervalue;

end

