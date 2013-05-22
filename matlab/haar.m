function [ xmperframe ] = haar( filename )
%HAAR calculates HAAR-like feature value vectors from a audio sample
%tic
%close all figures
delete(findall(0,'Type','figure'));

%define filters to use
Wfilters = [2,4,6,8,10,12,14,16,18,20];
%Wfilters = [2,6,12,16,18,20];
alpha = 1;
frames = 40;
Wshift = 0;

[samples, hzcrr, lster, freq] = recog(filename,0);

framesize = floor(freq/frames);
%fprintf('Selected frame size: %d', framesize);

total_frames = floor(size(samples,2)/framesize);

% IS array is created with size of sample-array.
% in C implementation, one would most likely calculate just the values for
% the current frame to save memory (1-frame's worth of 32bit ints instead
% of a complete 1sec sample, which would consume 32KB - the Arduino Due 
% has 96 in total...)
%global IS;
Icurrent = 0;
IS = zeros(size(samples,2)+framesize,1);


%samples(1,2)
%tic
% IS = cumsum(samples);
%toc
for i=1:size(samples,2)
   Icurrent = Icurrent + samples(1,i);
   IS(i) = Icurrent;
end

xm = zeros(total_frames,size(Wfilters,2));
t=0;
%toc
%tic
%for j=1:frames
%floor(size(samples,2)/frames)-1
for j=1:total_frames - 1
   
   xmcurrent = zeros(size(Wfilters,2),1);
   for wf=1:length(Wfilters)
       Wshift = alpha * Wfilters(wf);
       xmcurrent_filter = 0;
       %((framesize-Wfilters(wf))/Wshift + 1)
       for n=1:((framesize-Wfilters(wf))/Wshift + 1)
           t = j*framesize + n;
           %fprintf(' OneFilterValue: %d - %d - %d', IS(t+Wfilters(wf)),2 * IS(t+Wfilters(wf)/2),IS(t));
           onefiltervalue = IS(t+Wfilters(wf)) - 2 * IS(t+Wfilters(wf)/2) + IS(t);
           xmcurrent_filter = xmcurrent_filter + onefiltervalue;
       end
       %fprintf('filter wf = %d, value: %d\n',Wfilters(wf),xmcurrent_filter);
       xmcurrent(wf) = xmcurrent_filter;
   end
   %fprintf('frame %d\n', j);
   %xmcurrent
   xm(j,:) = xmcurrent;
   %xm(:,j) = transpose(xmcurrent);
end
% for each frame, do:
    % -calc IS values=C only-
    % for each filter, do:
        %for each 'N'
            % filtertotal xm += filtervalue;
%toc           
%x = [1:size(samples,2)];           
            
%x2 = transpose(framesize:framesize:size(samples,2));

% set output variables
xmperframe = xm;
%numfilters = size(Wfilters,2);

% %%
% figure('Name','Features: Haar','NumberTitle','off')
% 
% fprintf('size x: %d, size samples: %d, size x2: %d, size xm: %d\nnumber of filtes: %d\n',size(x,2),size(samples,2),size(x2,1),size(xm,1),size(xm,2));
% 
% [AX,H1,H2] = plotyy(x,samples,x2,xm);
% %%
% 
% %set(H2,'LineWidth',2,'Color','Red');
% %legend('Sample-data','ZCR per frame');
% player = audioplayer(transpose(samples), freq);
% 
% ylimits = get(gca, 'YLim'); % get the y-axis limits
% plotdata = [ylimits(1):0.1:ylimits(2)];
% hold on;
% hline = plot(repmat(0, size(plotdata)), plotdata, 'Color', 'c', 'LineWidth',2);
% 
% player.TimerFcn = {@plotMarker, player, gcf, plotdata}; % timer callback function (defined below)
% player.TimerPeriod = 0.01;
% 
% playblocking(player);
% 
% %%
% kmeanstest(xm);

end



%% ------------------------------------------------------------------------
%% the timer callback function definition
function plotMarker(...
    obj, ...            % refers to the object that called this function (necessary parameter for all callback functions)
    eventdata, ...      % this parameter is not used but is necessary for all callback functions
    player, ...         % we pass the audioplayer object to the callback function
    figHandle, ...      % pass the figure handle also to the callback function
    plotdata)           % finally, we pass the data necessary to draw the new marker

% check if sound is playing, then only plot new marker
if strcmp(player.Running, 'on')
    
    % get the handle of current marker and delete the marker
    hMarker = findobj(figHandle, 'Color', 'c');
    delete(hMarker);
    
    % get the currently playing sample
    x = player.CurrentSample;
    
    % plot the new marker
    plot(repmat(x, size(plotdata)), plotdata, 'Color', 'c', 'LineWidth',2);

end

end

