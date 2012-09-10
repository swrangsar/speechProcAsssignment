function sourceFilterSystem(F1, B1, F0)
%SOURCEFILTERSYSTEM Models a filter system based on a single formant resonator.

Fs = 16000;
impulseResponse = singleFormantResonator(F1, B1);
impulseResponse = impulseResponse(1:(Fs/2)+1);
length(impulseResponse)

duration = 2;
itlen = (duration*Fs);
impulseTrain = zeros(1,itlen+1);
for k = 1:round(Fs/F0):itlen+1
    impulseTrain(k) = 1;
end
y = conv(impulseResponse, impulseTrain, 'same');
n = 0:length(y)-1;
t = n/Fs;
figure, plot(t, y);
title(['Time domain waveform for F1 = ', num2str(F1), ' Hz, B1 = ', num2str(B1), ' Hz, F0 = ', num2str(F0)]);
xlabel('Time (sec)');
ylabel('Output y(t)');

sound(y, Fs);
