%/media/rick/8156-6047/audio/sounds/

function ret = recog(filename,centervalue)

[y, freq, bits] = wavread(filename,'native');

y = transpose(y);

fprintf('\nSampling frequency: %d, bitsize: %d, number of sample values: %d\n', freq, bits, size(y,2))
    
x = [1:size(y,2)];

%plot(x,y)

number_of_samples = 40;

y_1sec_sample = y(1:freq);
framesize = freq/number_of_samples;

x2 = 1:framesize:freq;
y2 = zeros(number_of_samples);

for i=1:number_of_samples
   y_frame = y_1sec_sample(((i-1)*framesize+1): i*framesize);
   
   lastposition = 0;
   currentposition = 0;
   frame_zcr = 0;
   
   
   for j=1:framesize
       if y_frame(j) >= centervalue
           currentposition = 2;
       else
           currentposition = 1;
       end
       if lastposition == 1 && currentposition == 2
          frame_zcr = frame_zcr + 1; 
       end
       if lastposition == 2 && currentposition == 1
           frame_zcr = frame_zcr + 1;
       end
       lastposition = currentposition;
   end
   
   y2(i) = frame_zcr;
   
   %fprintf('Frame %d: %d\n',i,frame_zcr)
end

[AX,H1,H2] = plotyy(x,y,x2,y2);

set(H2,'LineWidth',2,'Color','Red');
legend('Sample-data','ZCR per frame');

%bereken HZCRR
mean_zcr = mean(y2);
avg_zcr = mean_zcr(1);
higher = 0;
lower = 0;

for k=1:size(y2,2)
    if (y2(k) >= avg_zcr)
       higher = higher + 1;
    else
       lower = lower + 1;
    end
end

hzcrr = higher/lower;

fprintf('Gemiddelde ZCR: %3.4f\nHoger dan gem: %d, Lager dan gem: %d\nHZCRR = %1.2f\n',avg_zcr,higher,lower,hzcrr);


%bereken H(STE)R



ret = hzcrr;