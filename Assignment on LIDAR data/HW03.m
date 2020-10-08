%% Prajval Vaskar
% Assignment 3
clear all
clc
%% Question_1
% Select a frame (or a few frames) of LiDAR data file, parse the file and visualize the 3D point cloud of this frame, colored by its reflectivity value.
% Parsing the bin files 
fid = fopen('002_00000000.bin');
data = fread(fid,'single');
array_x = [];
array_y = [];
array_z = [];
array_r = [];
for j = 1:4:length(data)       
    array_x = [array_x,data(j)];      %Array of X-coordinates
end
for i= 2:4:length(data)
    array_y = [array_y,data(i)];    %Array of Y-coordinates
end
for i = 3:4:length(data)
    array_z = [array_z,data(i)];    %Array of Z-coordinates
end
for i = 4:4:length(data)
    array_r = [array_r,data(i)];    %Array of reflectance value.
end

% Visualization of pointcloud in cartesian coordinates.
figure(1)
ptCloud = pointCloud([array_x(:),array_y(:),array_z(:)],'Intensity',array_r(:))
pcshow(ptCloud)
title('Pointcloud of LIDAR data')
xlabel('X-coordinates')
ylabel('Y-coordinates')
zlabel('Z-coordinates')

%% Question_2
% Choose a 3-D resolution granularity, perform voxel filter (or box grid filter) to down-sample all the 3D point cloud points to the 3D voxel space points, and visualize the result points.
% Downsampling using boxgrid filter
% percentage = 0.3
gridStep = 0.7;
% maxNumPoints = 30;
% %pcdownsample = pcdownsample(ptCloud,'nonuniformGridSample',maxNumPoints);
% % pcdownsample = pcdownsample(ptCloud,'random',percentage)
pcdownsampled = pcdownsample(ptCloud,'gridAverage',gridStep);    %Box-grid filter
figure(2)
pcshow(pcdownsampled)
title('Pointcloud visualization using Box grid filter')
xlabel('X-coordinates')
ylabel('Y-coordinates')
zlabel('Z-coordinates')

%% Question_3A
% Apply RANSAC algorithm (or any others you prefer) to the 3D voxel space points to find a ground plane model. Print out your plane model parameter values result, visualize the plane with the points in the 3D;
% M-estimator Sample Consensus (MSAC) algorithm.
tic                         %Tic-toc for calculating time complexity of an algorithm
maxDistance = 1;
referenceVector = [0,0,1];
maxAngularDistance = 0.4;

[model1,inlierIndices,outlierIndices] = pcfitplane(pcdownsampled,...
            maxDistance,referenceVector,maxAngularDistance);
plane1 = select(pcdownsampled,inlierIndices);
remainPtCloud = select(pcdownsampled,outlierIndices);
model_parameters = model1.Parameters  %Model parameters
figure(3)
pcshow(plane1)
title('Visualization of ground plane with the points in the 3D without plane visualization')
xlabel('X-coordinates')
ylabel('Y-coordinates')

figure(4)
pcshow(plane1)
hold on
plot(model1)
title('Visualization of ground plane with the points in the 3D with plane visualization')
xlabel('X-coordinates')
ylabel('Y-coordinates')
toc

%% Question 3C
%Remove all the ground planes points in the 3D voxel space points, visualize all the off-ground points in the 3D 
removed_ground = select(pcdownsampled,outlierIndices,'OutputSize','full')
[removed_ground_invalid,indices] = removeInvalidPoints(removed_ground);
figure(5)
pcshow(removed_ground_invalid)
title('Pointcloud of off gorunds points')
xlabel('X-coordinates')
ylabel('Y-coordinates')
zlabel('Z-coordinates')
%% Question 4
%Perform a x-y projection to the off-ground points and get a 2D matrix (you decide what is the element value) and visualize the 2D matrix as an image.
x = removed_ground_invalid.Location(:,1);
y = removed_ground_invalid.Location(:,2);
i = removed_ground_invalid.Intensity(:);
z = zeros(length(removed_ground_invalid.Location),1);
twodim_matrix =[x,y];
ptCloud2d = pointCloud([x(:),y(:),z])   %Keeping z = 0 for all values of x and y (z is mandatory arg in pointCloud)
%Method 1 using pcshow function
figure(6)
pcshow(ptCloud2d)
title('Visualization of 2D image of the off-ground points')
xlabel('x-coordinates of the points')
ylabel('y-coordinates of the points')

%Method 2 Using scatter on 2D plot.
figure(7)
scatter(x(:),y(:),0.1,'w')
set(gca,'color',[0 0 0])
title('Visualization of 2D image of the off-ground points')
axis equal
xlabel('x-coordinates of the points')
ylabel('y-coordinates of the points')

%% Question 5
%Based on the raw point cloud data,which is in Cartesian Coordinate, represent and visualize all the point cloud in Polar Coordinate (with horizontal and vertical angles and distance to the original) 
X = ptCloud.Location(:,1);
Y = ptCloud.Location(:,2);
Z = ptCloud.Location(:,3);
in = ptCloud.Intensity(:,1);
[azimuth,elevation,r] = cart2sph(X,Y,Z);
[a,b,c] = sph2cart(azimuth,elevation,r);
z_polar = zeros(length(azimuth),1);
ptCloud_sphere = pointCloud([a(:),b(:),c(:)],'Intensity',in(:))
figure(8)
[e, f, g] = sphere;
mesh(70*e,70*f,70*g, 'Marker', 'none', 'EdgeColor', 'w', 'FaceColor', 'none', 'LineStyle', '-')
hold on;
plot3(0, 0, 0, '+r', 'MarkerSize', 1)
axis equal
axis off
hold on
pcshow(ptCloud_sphere)
title('Pointcloud 3d in spherical coordinates')

%Finally, generate the projected 2D depth image w.r.t horizontal and vertical angles, with intensity value using the distance. Visualize the 2D depth image 
%Top view 2d depth image
figure(9)
sphere_2d = scatter(a(:),b(:),0.3,c(:))
axis equal
set(gca,'color',[0 0 0])
axis on
title('Visualization of 2D image (Top view) with depth visualization in color')
xlabel('X coordinates')
ylabel('Y coordinates')

% Projected 2d depth image in y and z axis 
figure(10)
twod_polar = scatter(b(1000:25000),c(1000:25000),0.3,a(1000:25000));
set(gca,'color',[0 0 0])
axis equal
axis on
title('Visualization of 2D image with depth visualization in color')
xlabel('Y coordinates')
ylabel('Z coordinates')















    

    
    
    
    

