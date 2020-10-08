%% Question 3
clear all
close all
clc
%Question 3.1
figure()
I = imread('ParkingLot.jpg');
imhist(I);
title('Histogram distribution of image')
xlabel('Number of pixels')
ylabel('Frequency')
figure()
BW=im2bw(I,0.93);    %Grayscale to Binary transform 0.93 threshold value.
BW=imfill(BW,'holes');
imshow(BW);
title('Converting grayscale image to binary image')

%%
%Question 3.2
%BW = edge(black,'canny');
[H,T,R] = hough(BW,'RhoResolution',0.1,'Theta',-90:0.5:89);
figure()
subplot(2,1,1)
imshow(I);
title('Original Image')
subplot(2,1,2)
imshow(imadjust(rescale(H)),'XData',T,'YData',R,...
      'InitialMagnification','fit');
title('Hough transform of ParkingLot');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal;
colormap(gca,hot);
[H,theta,rho] = hough(BW);
hold on;
P = houghpeaks(H,8,'threshold',ceil(0.03*max(H(:))));
x = theta(P(:,2));
y = rho(P(:,1));
plot(x,y,'s','color','white'); % Find lines and plot them
lines = houghlines(BW,theta,rho,P,'FillGap',400,'MinLength',50); 
figure()
imshow(I)
title('Parking space lines in image', 'FontSize', 10, 'Interpreter', 'None');
hold on
color = ['r','y','g','b','m','c','k','r'];
color_p = ['k','r','y','g','b','m','k','y'];

[row,columns] = size(BW);
for k = 1:length(lines)
  xy = [lines(k).point1; lines(k).point2];
  %Get the equation of the line
  x1 = xy(1,1);
  y1 = xy(1,2);
  x2 = xy(2,1);
  y2 = xy(2,2);
  slope = (y2-y1)/(x2-x1);
  xLeft = 1; % x is on the left edge
  yLeft = slope * (xLeft - x1) + y1;
  xRight = columns; % x is on the right edge.
  yRight = slope * (xRight - x1) + y1;
  plot([xLeft, xRight], [yLeft, yRight], 'LineWidth',2,'Color',color(k));  
  % Plot original points on the lines .
  plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color',color_p(k)); 
  plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color',color_p(k));
  z(k,:) = [lines(k).point1,lines(k).point2];
end
%% Q3.4 For finding vertices of the parking space
figure()
imshow(I)
title('Parking space lines in image', 'FontSize', 10, 'Interpreter', 'None');
hold on
color = ['r','y','g','b','m','c','k','r'];
color_p = ['k','r','y','g','b','m','k','y'];

[row,columns] = size(BW);
for k = 1:length(lines)
  xy = [lines(k).point1; lines(k).point2];
  %Get the equation of the line
  x1 = xy(1,1);
  y1 = xy(1,2);
  x2 = xy(2,1);
  y2 = xy(2,2);
  slope = (y2-y1)/(x2-x1);
  xLeft = 1; % x is on the left edge
  yLeft = slope * (xLeft - x1) + y1;
  xRight = columns; % x is on the right edge.
  yRight = slope * (xRight - x1) + y1;
  plot([xLeft, xRight], [yLeft, yRight], 'LineWidth',2,'Color',color(k));  
  % Plot original points on the lines .
  plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','red'); 
  plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','yellow');
  z(k,:) = [lines(k).point1,lines(k).point2];
end
%plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','black');
hold on
X1 = [z(1,1),z(2,1),z(3,1),z(4,1),z(5,1),z(7,1)];
Y1 = [z(1,2),z(2,2),z(3,2),z(4,2),z(5,2),z(7,2)];
X2 = [z(1,3),z(2,3),z(3,3),z(4,3),z(5,3),z(7,3)];
Y2 = [z(1,4),z(2,4),z(3,4),z(4,4),z(5,4),z(7,4)];
Z1 = [z(6,1) z(6,3)];
Z2 = [z(6,2) z(6,4)];
clr = ['r','b','y','c','m','k'];
for i =1:6
lx = [X1(i), X2(i)]
ly = [Y1(i), Y2(i)]
[mi(i),ni(i)] = polyxpoly(lx,ly,Z1,Z2)
plot(mi(i),ni(i),'*','LineWidth',2,'Color',clr(i))
end
hold on
A = [mi(4) mi(2) z(2,1) z(4,1) mi(4) ]
B = [ni(4) ni(2) z(2,2) z(4,2) ni(4)]
plot(A,B,'LineWidth',2,'Color','red')
hold on
A = [mi(2) mi(3)  z(3,1) z(2,1) mi(2) ]
B = [ni(2) ni(3)  z(3,2) z(2,2) ni(2)]
plot(A,B,'LineWidth',2,'Color','green')
hold on
A = [mi(3) mi(1)  z(1,1) z(3,1) mi(3) ]
B = [ni(3) ni(1)  z(1,2) z(3,2) ni(3)]
plot(A,B,'LineWidth',2,'Color','yellow')
hold on
A = [mi(1) mi(5)  z(5,1) z(1,1) mi(1) ]
B = [ni(1) ni(5)  z(5,2) z(1,2) ni(1)]
plot(A,B,'LineWidth',2,'Color','cyan')
hold on
A = [mi(4) mi(2)  z(2,3) z(4,3) mi(4) ]
B = [ni(4) ni(2)  z(2,4) z(4,4)  ni(4)]
plot(A,B,'LineWidth',2,'Color','black')
hold on
A = [mi(2) mi(3)  z(3,3) z(2,3) mi(2) ]
B = [ni(2) ni(3)  z(3,4) z(2,4)  ni(2)]
plot(A,B,'LineWidth',2,'Color','magenta')
hold on
A = [mi(3) mi(1)  z(1,3) z(3,3) mi(3) ]
B = [ni(3) ni(1)  z(1,4) z(3,4)  ni(3)]
plot(A,B,'LineWidth',2,'Color','blue')

