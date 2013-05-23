function [ samples, info, framesize ] = read_wav_file( filename, frames )
%READ_WAV_FILE Loads wav-file into memory and splits in frames
%   Reads the wav-file from disk and returns the samples, split by frame

[y, freq] = audioread(filename,'native');
info = audioinfo(filename);

%samples = transpose(y)

framesize = floor(freq/frames);

samples = transpose(reshape(y(1:framesize*frames*info.Duration),framesize,[]));

end

