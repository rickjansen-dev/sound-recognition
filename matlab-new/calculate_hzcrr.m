function [ hzcrr, zcr ] = calculate_hzcrr( samples )
%CALCULATE_HZCRR Calculates the HZCRR value of a sound sample
%   Calculates the ZCR value of every frame, then calculates the ratio
%   of the number of frames that are higher than 1.5 * average zcr

zcr = sum(abs(diff(samples>0,1,2)),2)/length(samples);

threshold = mean(zcr) * 1.5;
hzcrr = sum(zcr>threshold)/length(zcr);

end