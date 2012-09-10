function output = vowelFilterSystem(vowel, F0)
%VOWELFILTERSYSTEM Models a vowel filter system based on a given pitch.

Fs = 16000;
impulseResponse = vowelResonator(vowel);
impulseResponse = impulseResponse(1:Fs);
% length(impulseResponse)

duration = 2;
step = round(Fs/F0);
numStep = ceil(duration*Fs/step);
itlen = (numStep*step);
impulseTrain = zeros(1,itlen);
for k = 1:step:itlen
    impulseTrain(k) = 1;
end
y = conv(impulseResponse, impulseTrain, 'same');
output = y;
y = y(1:Fs/2);
n = 0:length(y)-1;
t = n/Fs;
figure, plot(t, y);
title(['Time domain waveform for vowel /', vowel, '/ and F0 = ', num2str(F0)]);
xlabel('Time (sec)');
ylabel('Output y(t)');

sound(y, Fs);
