function [impulseResponse] = vowelResonator(vowel)
%VOWELRESONATOR Creates a new filter WITH 3 formant frequencies.
%  VOWELRESONATOR('VOWEL') creates a new transfer function H(z)
%  for a digital filter with three formants. It uses the input
%  string 'VOWEL' to do
%  this. It also plots the magnitude response (dB magnitude vs frequency)
%  and impulse response.

switch vowel;
    case 'a'
        F1 = 730; F2 =1090; F3 = 2440;
    case 'i'
        F1 = 270; F2 = 2290; F3 = 3010;
    case 'u'
        F1 = 300; F2 = 870; F3 = 2240;
    otherwise
        error('Unknown or undefined vowel.')
end

Bw = 100;
Fs = 16000; % 16 kHz
poleRadius = exp(-(pi*Bw/Fs));
poleTheta = 2*pi*F1/Fs;
pole1 = poleRadius*exp(1i*poleTheta);
pole2 = poleRadius*exp(-1i*poleTheta);

M = 8000;
step = 1;
f = -M:step:M;
r = 1;
z = r*exp(1i*2*pi*f/Fs);
H1 = (z.*z)./((z-pole1+eps).*(z-pole2+eps));
poleTheta = 2*pi*F2/Fs;
pole1 = poleRadius*exp(1i*poleTheta);
pole2 = poleRadius*exp(-1i*poleTheta);
H2 = (z.*z)./((z-pole1+eps).*(z-pole2+eps));
poleTheta = 2*pi*F3/Fs;
pole1 = poleRadius*exp(1i*poleTheta);
pole2 = poleRadius*exp(-1i*poleTheta);
H3 = (z.*z)./((z-pole1+eps).*(z-pole2+eps));
H = H1.*H2.*H3;


% mag = 20*log10(abs(H));
% figure, plot(f, mag);
% title(['Magnitude plot for vowel /', vowel, '/']);
% xlabel('Frequency (Hz)');
% ylabel('Magnitude (dB)');

impulseResponse = real(ifft(ifftshift(H))); % do ifft on non-centered Fourier transform
% n = 0:1:((M*2)/step);
% t = n/Fs;
% figure, plot(t, impulseResponse);
% title(['Impulse response for vowel /', vowel, '/']);
% xlabel('Time (sec)');
% ylabel('Impulse response h(t)');