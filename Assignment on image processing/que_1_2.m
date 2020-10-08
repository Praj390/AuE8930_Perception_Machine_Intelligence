clear all
%Prajval Vaskar
%HW02
%% Question1
%Question 1.1
image_color = imread('Lenna.jpg');  % Read Image
redChannel = image_color(:, :, 1);
greenChannel =  image_color(:, :, 2);
blueChannel =  image_color(:, :, 3);
LennaGray = 0.299*redChannel + 0.587*greenChannel + 0.114*blueChannel ;  % NTSC approach
figure(1)
imshow(LennaGray); %RBG to Gray output
title('Conversion of RGB to gray using NTSC approach')

%% Q1.2. Downsampling of the image
%Down-sampling image “LennaGray.jpg” from size 256x256 to 64x64
[rows,columns] = size(LennaGray);
i = 1; j=1;
LennaGray_down = uint8(zeros(rows/4, columns/4));    %For conversion of 256*256 image into 64*64.
for x = 1:4:rows
    for y = 1:4:columns
        LennaGray_down(i,j) = LennaGray(x,y);
        j = j+1;
    end
i = i+1;
j =1;
end
 figure(),
 imshow(LennaGray_down);
 title('Downsampling of 256*256 into 64*64','FontSize',9)
 axis on
%% Question 1.3 - Convolution of sobel kernel
%Sobel Kernel
Bx = [-1,0,1;-2,0,2;-1,0,1]; % Sobel Gx kernel
By = Bx'; % gradient Gy
Yx = filter2(Bx,LennaGray); % convolve in 2d
Yy = filter2(By,LennaGray);
figure()
G = sqrt(Yy.^2 + Yx.^2); % Find magnitude
Gmin = min(min(G)); dx = max(max(G)) - Gmin; % find range
G = floor((G-Gmin)/dx*255); % normalise from 0 to 255
image(G); axis('image')
title('Convoluted image')
colormap gray 
figure()
imshow(LennaGray)
title('Original Image')
%Second method
% h1 = [-1,0,1;-2,0,2;-1,0,1];
% h2=rot90(rot90(h1));
% f=im2double(LennaGray);
% [r c]=size(f);
% 
% g=padarray(f,[1 1]);
% for i=2:r+1
%     for j=2:c+1
%         sm1=0;
%          m=-1;
%              for k=1:3;
%                  n=-1;
%                   for l=1:3
%                     sm1=sm1+h2(k,l)*g(i+m,j+n); 
%                     n=n+1;
%                   end
%                  m=m+1;
%              end
%         cv(i-1,j-1)=sm1;
%     end
% end
% figure()
% imshow(f)
% title('Original Image');
% figure()
% imshow(cv)
% title('Convolved Image using sobel kernel');
%% Question 2
%Question 2.1 - Histogram analysis and visualiation
[M,N]=size(LennaGray);
bitlevel = 8;
bit_comb = (2^bitlevel);
hist_data = zeros(1,bit_comb);

for i = 1:M
    for j=1:N
        val = LennaGray(i,j)+1;
        count = (hist_data(val))+1;
        hist_data(val) = count;
    end
end
figure();
stem(0:bit_comb-1,hist_data,'Marker','none','Color','g');
title('Histogram analysis of an image');
xlabel('Number of pixels')
ylabel('Frequeney')

%% Question 2.2 - Calculate and visualise accumulative histogram distribution
 c_hist=zeros(1,bit_comb);
  for j=1:columns
       if(j ==1)
       c_hist(j)=hist_data(j);
       else
       c_hist(j)=hist_data(j)+c_hist(j-1);         
       end
  end
figure()
stem(0:bit_comb-1,c_hist,'Marker','none','Color','c')
title('Accumulative histogram distibution')
xlabel('Number of pixels')
ylabel('Accumulative Frequeney')
  

 
%% Question_2.3
%  Histogram equalization
r = size(LennaGray,1);
c = size(LennaGray,2);
ah = uint8(zeros(r,c));
num = r*c;
f = zeros(256,1);
pdf = zeros(256,1);
cdf = zeros(256,1);
cum = zeros(256,1);
out = zeros(256,1);
for p = 1:r
    for q=1:c
        value =(LennaGray(p,q));
        f(value+1) = f(value+1)+1;
        pdf(value+1)=f(value+1)/num;
    end
end
sum = 0; L =255;
for s = 1:size(pdf)
    sum =sum+f(s);
    cum(s) = sum;
    cdf(s) = cum(s)/num;
    out(s) = round(cdf(s)*L);
end
for l=1:r;
    for y=1:c;
        ah(l,y) = out(LennaGray(l,y)+1);
    end
end

figure()
imshow(ah);
title('Image after histogram equalization')

figure()
imshow(LennaGray);
title('Image before histogram equalization')

% he = histeq(LennaGray)
% figure() 
% imshow(he);
% title('Histogram equalization using MATLAB function')
% Distribution
a_hist =zeros(1,bit_comb);
for i = 1:M
    for j=1:N
        value = ah(i,j)+1;
        count = (a_hist(value))+1;
        a_hist(value) = count;
    end
end
figure()
stem(0:bit_comb-1,a_hist,'Marker','none','Color','[0.8500 0.3250 0.0980]')
title('Histogram distibution after histogram equaliziation')
xlabel('Number of pixels')
ylabel(' Frequeney')




    
    
        

 





    