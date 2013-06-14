function [ haar ] = calculate_haar( samples, filters )
%CALCULATE_HAAR Calculates Haar-Like filter values per frame
%   Per frame, for each filter, the Haar-Like filter value is calculated
%   and added to the output matrix

%Wfilters = [2,8,14,20];
Wfilters = filters;

%sanity check
if length(Wfilters) < 1
    return
end

%Wfilters = [2,6,12,16,18,20];
alpha = 1;
Wshift = 0;
framesize = size(samples,2);


IS = cumsum(cast(samples,'double'),2);

for i=2:size(samples,1)
   IS(i,:) = IS(i,:) + IS(i-1,end); 
end


haar = zeros(size(samples,1),length(Wfilters));


for i=1:size(samples,1)
   % for each frame, do:
   
   xmcurrent = zeros(1,length(Wfilters));
   
   for wf=1:length(Wfilters)
      % for each filter, do:
      Wshift = alpha * Wfilters(wf);
      xmcurrent_filter = 0;
      
      for t=1:((framesize-Wfilters(wf))/Wshift + 1)
         % for each n, do:
         onefiltervalue = IS(i,t+Wfilters(wf)) - 2 * IS(i,t+Wfilters(wf)/2) + IS(i,t);
         xmcurrent_filter = xmcurrent_filter + onefiltervalue;
      end
      
      xmcurrent(wf) = xmcurrent_filter;
   end
   
   haar(i,:) = xmcurrent;
end



end

