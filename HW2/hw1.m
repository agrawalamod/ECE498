clear all;
close all;
h = [1/8 1/8 1/8 1/8 1/8 1/8 1/8 1/8];
H = fft(h,8);

figure;
stem(abs(H)); 
xlabel('H[k]'); 
ylabel('FFT Magnitude');

[x,Fs] = audioread('voice.m4a');
X = fft(x, Fs);
figure;
plot((1:length(X))/length(X)*Fs, abs(X)); 
xlabel('Frequency (Hz)'); 
ylabel('FFT Magnitude');

convx = conv(h,x);
convX = fft(convx, Fs);
figure;
plot((1:length(convX))/length(convX)*Fs, abs(convX)); 
xlabel('Frequency (Hz)'); 
ylabel('FFT Magnitude');



