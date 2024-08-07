clear all 
close all
clc

%% construct parameters

% boresight angles and lever arm of velodyne LiDAR in IMU frame (from LCP.txt, Sequece A)
Rv2i=rotxyz([178.869094016 -44.844306361 1.933645172]*pi/180);
tv2i=[0.111744 0.010389 -0.181398];
Tv2i=[Rv2i; tv2i];
% fixed rotation matrix from LiDAR to imu frame
Rs2v=rotxyz([0 0 -90]*pi/180);
% Ts2i contains rotation matrix and lever arm from LiDAR to imu frame
Ts2i=Tv2i*Rs2v;

% boresight angles and lever arm of ladybug camera system in IMU frame (from CCP.txt, Sequece A)
Rlb2i=rotxyz([0.15, -0.05, -179.65]*pi/180);
tlb2i=[-0.031239, 0, -0.1115382];
Tlb2i=[Rlb2i; tlb2i];
% fixed rotation matrix from the camera frame to imu frame
Rc2lb=rotxyz([180 0 0]*pi/180);
% Tc2i contains rotation matrix and lever arm from camera to IMU frame
Tc2i=Tlb2i*Rc2lb;

% image size
imSize=[8000, 4000];

% lidar scan timestamp (extracted from lidar data file name)
folder_L = uigetdir(); % open lidar data directory (select directory '../Sequence A/LidarData')
fileList_L = dir(fullfile(folder_L, '*.bin'));
filename_L = {fileList_L.name};
time_L = strrep(filename_L, '.bin', '');
timeL = cellfun(@str2num,time_L)';

% image sequence timestamp (extracted from groundtruth txt file)
fid_gt = fopen('../Sequence D/GroundTruth_LBP_YU_campus_UTM_Zone_17N_r.txt');
fgetl(fid_gt);
%File format: ImNum(1), Cam(2), CamImNm(3), Rotate(4), Error(5), GPSTime(6), Index(7), Filename(8), East(9), North(10), Height(11), Omega(12), Phi(13), Kappa(14), img_h(15), img_w(16)
cell_data_raw = textscan(fid_gt, '%d %d %d %d %d %f %d %s %f %f %f %f %f %f %d %d');     
fclose(fid_gt);
timeC = cell_data_raw{6}*10^9;

% time interval between image timestamp and lidar scan timestamp
Tindex = zeros(size(timeC));
for i = 1:length(timeC)
    [minVal, Tindex(i)]=min(abs(timeL-timeC(i)));
end
% Tindex contains the time indices of lidar scans to the sychronized images
Tindex = zeros(size(timeC));
for i = 1:length(timeC)
    [minVal, Tindex(i)]=min(abs(timeL-timeC(i)));
end
Tinterval=(timeL(Tindex)-timeC);

% loop over all images 
for i =1:length(timeC)
    
    % load velodyne points from .bin file
    filename = sprintf('../Sequence D/LidarData/%05d.bin', timeL(Tindex(i)));
    fid_velo = fopen(filename,'rb');
    [points,count]=fread(fid_velo,'float32');
    fclose(fid_velo);
    clearvars velo
    velo(1,:) = points(1:4:end);
    velo(2,:) = points(2:4:end);
    velo(3,:) = points(3:4:end);

    % Transform laser point from sensor frame to imu frame
    clearvars xi
    xi(1:3,:)=[Ts2i(1:3,1:3) Ts2i(4,1:3)']*[velo;ones(1,size(velo,2))];
     
    % Project point 3d point in the camera coordinate systme onto the panoramic image:
    panoWidth = imSize(1);
    panoHeight = imSize(2);

    % Transform laser point from imu frame to camera frame
    xc=inv(Tc2i(1:3,1:3))*(xi-Tc2i(4,1:3)');

    % The figure visualizes mapping results
    hp=figure(1)
    
    % bearing vector to theta phi
    theta = atan2(xc(2,:),xc(1,:))/pi*180 + 180;
    phi = atan2(sqrt(xc(1,:).^2+xc(2,:).^2),xc(3,:))/pi*180;

    % theta phi to image coordinates
    up = panoWidth - (theta/360.0)*panoWidth;
    vp = phi/180.0*panoHeight;
    
    % read the panoramic image
    panonames = cell_data_raw{8};
    panoname = sprintf('../Sequence D/PanoramicImages/%s', strrep(panonames{i,1},'.tif','.jpg'));
    Ip = imread(panoname);
    imshow(Ip)
    hold on
    title('Panoramic Image') 
    
    colp = size(Ip,2) + 1;
    rowp = size(Ip,1) + 1;
        
    %range of points
    range_camc = xc.*xc;
    rangep = sqrt(sum(range_camc,1));
    [sorted_rangep ii_rp] = sort(rangep);
        
    %Image points sorted with Z/range coordinate
    up = up(ii_rp);
    vp = vp(ii_rp);
    temp_min = 1;
    step = 1; % in meters

    index_p = find(up(1,:) > 1 & up(1,:) < colp &  vp(1,:) > 1 & vp(1,:) < rowp); 
    Xp_final = up(index_p);
    Yp_final = vp(index_p);

    sorted_p = sorted_rangep(index_p);
        
    numColors = 50;
    color = hsv(numColors);
    
    for k = 1:numColors
        tempp_index = find(sorted_p(:) >= temp_min & sorted_p(:) < (temp_min + step));
        temp_Xp_final = Xp_final(tempp_index);
        temp_Yp_final = Yp_final(tempp_index);
        temp_min = temp_min + step;
        scatter(temp_Xp_final,temp_Yp_final,2.5, color(k,:) );   
    end
        
    hold off;
    
end
