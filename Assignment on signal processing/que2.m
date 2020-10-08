%% Prajval Vaskar
% Question no 
clear all
clc
%% Time domain analysis.
% Signal is in microseconds.
n = 0:1:1000; %Given sample data size
y = heaviside(n); %Heaviside function 
Fs = (10^6)/2 ;  %Sampling frequency in Mhz
figure()
plot(y); %Used for plotting discrete signals.
axis([0 1000 -1 2]);
xlabel('Time in microseconds')
ylabel('Amplitude')
title('Time domain plot of discrete time signal')

%% Fourier Transformation of above discrete signal.
x = (abs(fft(y)));   %Fast Fourier Transform
figure()
[bw,flo,fhi] = powerbw(x)
plot(x)
hold on
xlabel('frequency in MHz')
ylabel('Amplitude')
title('Frequency domain plot of discrete time signal')


% Function for creating the array of discrete signal.
function y =heaviside(n);
y = 0*n;
y(find(n>= 500)) = 1;
end



