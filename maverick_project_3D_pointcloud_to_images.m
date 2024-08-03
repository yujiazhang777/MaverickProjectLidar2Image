clear all 
close all
clc

%% construct parameters

% boresight angles and lever arm of LiDAR in IMU frame (Sequece A)
Rs2i=rotxyz([178.869094016 -44.844306361 1.933645172]*pi/180);
ts2i=[0.111744 0.010389 -0.181398]';

% boresight angles and lever arm of ladybug camera system in IMU frame (Sequece A)
Rlbs2i=rotxyz([0.15, -0.05, -179.65]*pi/180);
Rlb2lbs=rotxyz([0, 0, 180]*pi/180);
Rlb2i=Rlbs2i*Rlb2lbs;
tlb2i=[-0.031239, 0, -0.1115382]';

% fixed boresight angles from 
Rc2lbc=rotxyz([0 0 -90]*pi/180)*rotxyz([180 0 0]*pi/180);

% image size
imSize=[8000, 4000];

% lidar scan timestamp (extracted from lidar data file name)
folder_L = uigetdir(); % open lidar data directory (select directory '../Sequence A/LidarData')
fileList_L = dir(fullfile(folder_L, '*.bin'));
filename_L = {fileList_L.name};
time_L = strrep(filename_L, '.bin', '');
timeL = cellfun(@str2num,time_L)';

% image sequence timestamp (extracted from groundtruth txt file)
fid_gt = fopen('../Sequence A/GroundTruth_LBP_HQ_WGS_84_UTM___zone_17N_s.txt');
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
    filename = sprintf('../Sequence A/LidarData/%05d.bin', timeL(Tindex(i)));
    fid_velo = fopen(filename,'rb');
    [points,count]=fread(fid_velo,'float32');
    fclose(fid_velo);
    clearvars velo
    velo(1,:) = points(1:4:end);
    velo(2,:) = points(2:4:end);
    velo(3,:) = points(3:4:end);

    xl=rotxyz([0 0 -90]*pi/180)*velo(1:3,:);

    % Transform laser point in sensor frame to imu frame
    clearvars xi
    xi(1:3,:)=[Rs2i ts2i]*[xl;ones(1,size(velo,2))];
     
%     Project point 3d point in the camera coordinate systme onto the panoramic image:
    panoWidth = imSize(1);
    panoHeight = imSize(2);
    
    Rcc2i=Rlb2i*Rc2lbc;
    tcc2i=tlb2i;

    xc=inv(Rcc2i)*(xi-tcc2i);

    xcc=[xc(2,:);-xc(1,:);xc(3,:)];

   % The figure visualizes mapping results
    hp=figure(1)
    
%     bearing vector to theta phi
    theta = atan2(xcc(2,:),xcc(1,:))/pi*180 + 180;
    phi = atan2(sqrt(xcc(1,:).^2+xcc(2,:).^2),xcc(3,:))/pi*180;

%     theta phi to image coordinates
    up = panoWidth - (theta/360.0)*panoWidth;
    vp = phi/180.0*panoHeight;
    
    % read the panoramic image
    panonames = cell_data_raw{8};
    panoname = sprintf('../Sequence A/PanoramicImages/%s', strrep(panonames{i,1},'.tif','.jpg'));
    Ip = imread(panoname);
    imshow(Ip)
    hold on
    title('Panoramic Image') 
    
    colp = size(Ip,2) + 1;
    rowp = size(Ip,1) + 1;
        
    %range of points
    range_camc = xcc.*xcc;
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
