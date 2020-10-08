%% Prajval Vaskar
% Question no 3

clear all
x = 20.* ones(1,500); % Discrete time signal
N = 0:499;  %Time range
sigma = 1; %Standard deviation
mean = 0;  % Mean
x_noise = normrnd(mean,sigma,[1,500]);  %White gaussian noise 
% Plotting x(k) and x'(k)[with white gaussian noise]
figure()
plot (x);   %Plotting signal
hold on
x_dot = x + x_noise;     % Adding gaussian noise to the signal
plot(x_dot);
ylim([15 25])
xlabel('Time in seconds')
ylabel('Amplitude')
title('Discrete time signal with constant amplitude of 20')
legend('Discrete signal','adding Gaussian noise')

%% For window size of 3 
h3k = [0.2709 0.44198 0.27901];  %Gaussian kernel for window size 3
m = length(x_dot);
n = length(h3k);
X = [x_dot,zeros(1,n)];
H = [h3k,zeros(1,m)];
% For convolution
for i=1:n+m-1
    Y(i)=0;
    for j=1:m
        if(i-j+1>0)
            Y(i)=Y(i)+X(j)*H(i-j+1);
        else
        end
    end
end
% Plotting x(k) and y(k) with window size 11
figure()
plot (x)
hold on
plot(Y)
xlim([0 500])
ylim([15 25])
xlabel('Time in second')
ylabel('Amplitude')
title('Applying Gaussian kernel using window size of 3')

%% For window size of 11
h11k = [0.000003 0.000229 0.005977 0.060598 0.24173 0.382925 0.24173 0.060598 0.005977 0.000229	0.000003]; %Gaussian kernel for window size 11
m = length(x_dot);
n = length(h3k);
X = [x_dot,zeros(1,n)];
H = [h11k,zeros(1,m)];
% For convolution
for i=1:n+m-1
    Yk(i)=0;
    for j=1:m
        if(i-j+1>0)
            Yk(i)=Yk(i)+X(j)*H(i-j+1);
        else
        end
    end
end
% Plotting x(k) and y(k) with window size 11
figure()
plot (x)
hold on
plot(Yk)
xlim([0 500])
ylim([15 25])
xlabel('Time in second')
ylabel('Amplitude')
title('Applying Gaussian kernel using window size of 11')







 