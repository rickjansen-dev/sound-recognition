avconv -i /media/rick/8156-6047/audio/sounds/44khz\ 16bit\ wav/117614__soundmary__door-close.wav -f u16le -acodec pcm_s16le -ar 8000 -loglevel quiet - | ./recog
