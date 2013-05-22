function [ lster, ste ] = calculate_lster( samples )
%CALCULATE_LSTER Calculates the LSTER value of a sound sample
%   Calculates the STE value of every frame, then calculates the ratio
%   of the number of frames that are lower than 0.5 * average STE

ste = sum(abs(cast(samples,'double')).^2,2);

threshold = mean(ste) * 0.5;
lster = sum(ste<threshold)/length(ste);

end
