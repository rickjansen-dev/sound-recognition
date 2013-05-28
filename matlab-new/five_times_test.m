%% Five Times Test
% Recording same sound 5 times
% compare Haar output of all 5 times

close all;

%% Read files & Calculate Haar
Wfilters = [2,4,6,8,10,12,14,16,18,20];

[s, info, fs] = read_wav_file('Z:\sounds\temp\doorknob\1.wav',40);
Xm1 = calculate_haar(s,Wfilters);
[s, info, fs] = read_wav_file('Z:\sounds\temp\doorknob\2.wav',40);
Xm2 = calculate_haar(s,Wfilters);
[s, info, fs] = read_wav_file('Z:\sounds\temp\doorknob\3.wav',40);
Xm3 = calculate_haar(s,Wfilters);
[s, info, fs] = read_wav_file('Z:\sounds\temp\doorknob\4.wav',40);
Xm4 = calculate_haar(s,Wfilters);
[s, info, fs] = read_wav_file('Z:\sounds\temp\doorknob\5.wav',40);
Xm5 = calculate_haar(s,Wfilters);
[s, info, fs] = read_wav_file('Z:\sounds\temp\doorknob\6.other.wav',40);
Xm6 = calculate_haar(s,Wfilters);

%% Create plottable data

X = 1:size(Xm1,1);
Y1 = zeros(size(Xm1,1),6);
Y2 = zeros(size(Xm1,1),6);
Y3 = zeros(size(Xm1,1),6);
Y4 = zeros(size(Xm1,1),6);
Y5 = zeros(size(Xm1,1),6);
Y6 = zeros(size(Xm1,1),6);
Y7 = zeros(size(Xm1,1),6);
Y8 = zeros(size(Xm1,1),6);
Y9 = zeros(size(Xm1,1),6);
Y10 = zeros(size(Xm1,1),6);

fprintf('size XM1: %d x %d\n',size(Xm1,1), size(Xm1,2));
fprintf('size XM2: %d x %d\n',size(Xm2,1), size(Xm2,2));
fprintf('size XM3: %d x %d\n',size(Xm3,1), size(Xm3,2));
fprintf('size XM4: %d x %d\n',size(Xm4,1), size(Xm4,2));
fprintf('size XM5: %d x %d\n',size(Xm5,1), size(Xm5,2));
fprintf('size XM6: %d x %d\n',size(Xm6,1), size(Xm6,2));

Xm1 = sort(Xm1,1);
Xm2 = sort(Xm2,1);
Xm3 = sort(Xm3,1);
Xm4 = sort(Xm4,1);
Xm5 = sort(Xm5,1);
Xm6 = sort(Xm6,1);

Y1(:,1) = Xm1(:,1); 
Y1(:,2) = Xm2(:,1); 
Y1(:,3) = Xm3(:,1); 
Y1(:,4) = Xm4(:,1);
Y1(:,5) = Xm5(:,1); 
Y1(:,6) = Xm6(:,1); 

Y2(:,1) = Xm1(:,2); 
Y2(:,2) = Xm2(:,2); 
Y2(:,3) = Xm3(:,2); 
Y2(:,4) = Xm4(:,2);
Y2(:,5) = Xm5(:,2); 
Y2(:,6) = Xm6(:,2); 

Y3(:,1) = Xm1(:,3); 
Y3(:,2) = Xm2(:,3); 
Y3(:,3) = Xm3(:,3); 
Y3(:,4) = Xm4(:,3);
Y3(:,5) = Xm5(:,3); 
Y3(:,6) = Xm6(:,3);

Y4(:,1) = Xm1(:,4); 
Y4(:,2) = Xm2(:,4); 
Y4(:,3) = Xm3(:,4); 
Y4(:,4) = Xm4(:,4);
Y4(:,5) = Xm5(:,4); 
Y4(:,6) = Xm6(:,4);

Y5(:,1) = Xm1(:,5); 
Y5(:,2) = Xm2(:,5); 
Y5(:,3) = Xm3(:,5); 
Y5(:,4) = Xm4(:,5);
Y5(:,5) = Xm5(:,5); 
Y5(:,6) = Xm6(:,5); 

Y6(:,1) = Xm1(:,6); 
Y6(:,2) = Xm2(:,6); 
Y6(:,3) = Xm3(:,6); 
Y6(:,4) = Xm4(:,6);
Y6(:,5) = Xm5(:,6); 
Y6(:,6) = Xm6(:,6); 

Y7(:,1) = Xm1(:,7); 
Y7(:,2) = Xm2(:,7); 
Y7(:,3) = Xm3(:,7); 
Y7(:,4) = Xm4(:,7);
Y7(:,5) = Xm5(:,7); 
Y7(:,6) = Xm6(:,7); 

Y8(:,1) = Xm1(:,8); 
Y8(:,2) = Xm2(:,8); 
Y8(:,3) = Xm3(:,8); 
Y8(:,4) = Xm4(:,8);
Y8(:,5) = Xm5(:,8); 
Y8(:,6) = Xm6(:,8); 

Y9(:,1) = Xm1(:,9); 
Y9(:,2) = Xm2(:,9); 
Y9(:,3) = Xm3(:,9); 
Y9(:,4) = Xm4(:,9);
Y9(:,5) = Xm5(:,9); 
Y9(:,6) = Xm6(:,9); 

Y10(:,1) = Xm1(:,10); 
Y10(:,2) = Xm2(:,10); 
Y10(:,3) = Xm3(:,10); 
Y10(:,4) = Xm4(:,10);
Y10(:,5) = Xm5(:,10); 
Y10(:,6) = Xm6(:,10); 

%% Plot data

figure('Name','Filter 1')

plot(X,Y1)

figure('Name','Filter 2')

plot(X,Y2)

figure('Name','Filter 3')

plot(X,Y3)

figure('Name','Filter 4')

plot(X,Y4)

figure('Name','Filter 5')

plot(X,Y5)

figure('Name','Filter 6')

plot(X,Y6)

figure('Name','Filter 7')

plot(X,Y7)

figure('Name','Filter 8')

plot(X,Y8)

figure('Name','Filter 9')

plot(X,Y9)

figure('Name','Filter 10')

plot(X,Y10)


