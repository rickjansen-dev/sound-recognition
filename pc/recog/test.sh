#avconv -i /media/rick/8156-6047/audio/sounds/44khz\ 16bit\ wav/117614__soundmary__door-close.wav -f u16le -acodec pcm_s8 -ar 8000 -loglevel quiet - | ./bin/recog

sox /media/rick/8156-6047/audio/sounds/44khz\ 16bit\ wav/117614__soundmary__door-close.wav -e unsigned-integer -b 8 -r 8000 -c 1 -t raw - | ./bin/recog
