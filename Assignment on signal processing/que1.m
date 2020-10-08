%% Prajval Vaskar
% Question no 1
clear all
clc
w = 500*pi;
w1 = 1000*pi;
w2 = 2000*pi;
Fs = 500;   %Sampling frequency in kHz
dt = 1/Fs;   % Sampling time

t = 0:dt:1; 
x = 2 + 3*cos(w*t) + 2 *cos(w1*t) + 3*sin(w2*t);   %Equation of signal 
figure()
plot(x);
xlabel('Time in seconds')
ylabel('Amplitude')
title('Signal Visualization in Time domain analysis')

%% Fast Fourier Transform
FFT = (fft(x));   %Fast Fourier Transform
absfft = abs(FFT);
figure()
plot(absfft)
%plot(f,abs(x)/N);
xlabel('Frequency in Hz');
ylabel('Amplitude of the signal ')
title('Magnitude Response');


