#avconv -i /media/rick/8156-6047/audio/sounds/44khz\ 16bit\ wav/117614__soundmary__door-close.wav -f u16le -acodec pcm_s8 -ar 8000 -loglevel quiet - | ./bin/recog

echo "Outputting bitsize 16, with Endianess: little"

sox /home/rick/audio/sounds/44khz\ 16bit\ wav/117614__soundmary__door-close.wav -e signed-integer -b 16 --endian little -r 8000 -c 1 -t raw - | ./bin/recog
