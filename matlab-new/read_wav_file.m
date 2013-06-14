function [ samples, info, framesize, y ] = read_wav_file( filename, frames )
%READ_WAV_FILE Loads wav-file into memory and splits in frames
%   Reads the wav-file from disk and returns the samples, split by frame

[y, freq] = audioread(filename,'native');
info = audioinfo(filename);

%samples = transpose(y)

framesize = floor(freq/frames);

%fprintf('framesize: %d, samples: %d, frames: %d, duration: %d, total: %d\n',framesize,size(y,1),frames,info.Duration,framesize*frames*info.Duration);

multiplier = floor(framesize*frames*info.Duration/framesize);
ymax = multiplier*framesize;

samples = transpose(reshape(y(1:ymax),framesize,[]));

end

