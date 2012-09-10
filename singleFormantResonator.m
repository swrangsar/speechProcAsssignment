function [impulseResponse] = singleFormantResonator(F1, B1)
%SINGLEFORMATRESONATOR Creates a new filter for a single formant resonator.
%  SINGLEFORMANTRESONATOR(F1, B1) creates a new transfer function H(z)
%  for a digital filter for a single formant resonator. It uses the input
%  formant frequency(F1), bandwidth(B1) and sampling frequency(Fs) to do
%  this. It also plots the magnitude response (dB magnitude vs frequency)
%  and impulse response.

Fs = 16000; % 16 kHz
poleRadius = exp(-(pi*B1/Fs));
poleTheta = 2*pi*F1/Fs;
pole1 = poleRadius*exp(1i*poleTheta);
pole2 = poleRadius*exp(-1i*poleTheta);

M = 8000;
step = 1;
f = -M:step:M;
r = 1;
z = r*exp(1i*2*pi*f/Fs);
H = (z.*z)./((z-pole1+eps).*(z-pole2+eps));
mag = 20*log10(abs(H));
% figure, plot(f, mag);
% title(['Magnitude plot for F1 = ', num2str(F1), ' Hz and B1 = ', num2str(B1), ' Hz']);
% xlabel('Frequency (Hz)');
% ylabel('Magnitude (dB)');

impulseResponse = real(ifft(ifftshift(H))); % do ifft on non-centered Fourier transform
n = 0:1:((M*2)/step);
t = n/Fs;
% figure, plot(t, impulseResponse);
% title(['Impulse response for F1 = ', num2str(F1), ' Hz and B1 = ', num2str(B1), ' Hz']);
% xlabel('Time (sec)');
% ylabel('Impulse response h(t)');