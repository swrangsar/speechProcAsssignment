function signal = rectangularVowelFilter(vowel, F0, windowLength)
%RECTANGULARVOWELFILTER Models a vowel filter system based on a given pitch.
% WINDOWLENGTH value must be in milliseconds.

Fs = 16000;
signal = vowelFilterSystem(vowel, F0);
rwindow = zeros(1,Fs);
T=1/Fs;
windowPeriod = windowLength/1000;
M = round(windowPeriod/T);
rwindow(1:M) = 1;
signal = signal.*rwindow;


Y = fftshift(fft(signal));
n = -length(Y)/2:(length(Y)/2)-1;
freq = n*(Fs/length(Y));
figure, plot(freq, abs(Y));
title(['Magnitude plot for vowel /', vowel, '/, F0 = ', num2str(F0), ' Hz and rectangular window of ', num2str(windowLength), ' ms']);
xlabel('Frequency (Hz)');
ylabel('Magnitude Y(f)');