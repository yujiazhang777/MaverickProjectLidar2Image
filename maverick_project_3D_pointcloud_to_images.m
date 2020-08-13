clear all 
close all
clc

% construct parameters

% boresight angles and lever arm of LiDAR in IMU frame
Rs2i=rotxyz([178.869094016 -44.844306361 1.933645172]*pi/180);
ts2i=[0.111744 0.010389 -0.181398]';

% boresight angles and lever arm of ladybug camera system in IMU frame
Rlbs2i=rotxyz([0.15, -0.05, -179.65]*pi/180);
tlb2i=[-0.031239, 0, -0.1115382]';

% image parameters
imSize=[2048, 2448];
pixSize=0.00345;

% % boresight angles and lever arm of camera0 in ladybug camera system
% Rc02lb=rotxyz([57.2627198408 89.7638080612 57.2629490239]*pi/180);
% tc02lb=[0.060847 -0.00013 0.0]';
% K0 = [1.5859316592/pixSize, 0, imSize(2)/2+0.0322059984/pixSize; ...
%         0 1.5859316592/pixSize imSize(1)/2+0.0502618632/pixSize; ...
%         0 0 1];

% % boresight angles and lever arm of camera1 in ladybug camera system
% Rc12lb=rotxyz([-50.8820899477 89.6812448429 -122.8274262447]*pi/180);
% tc12lb=[0.018885 -0.057757 0.000262]';
% K1 = [1.5687026352/pixSize, 0, imSize(2)/2-0.0404001072/pixSize; ...
%         0 1.5687026352/pixSize imSize(1)/2-0.0750032760/pixSize; ...
%         0 0 1];
% 
% % boresight angles and lever arm of camera2 in ladybug camera system
% Rc22lb=rotxyz([-14.1254722962 89.9377007520 -158.1394454076]*pi/180);
% tc22lb=[-0.049249 -0.035596 -0.000236]';
% K2 = [1.5744794256/pixSize, 0, imSize(2)/2+0.0560029392/pixSize; ...
%         0 1.5744794256/pixSize imSize(1)/2-0.0773933808/pixSize; ...
%         0 0 1];
% 
% % boresight angles and lever arm of camera3 in ladybug camera system
% Rc32lb=rotxyz([-122.1097966064 89.8767380426 22.1840663879]*pi/180);
% tc32lb=[-0.049247 0.035602 -0.000157]';
% K3 = [1.6017587136/pixSize, 0, imSize(2)/2-0.0167727408/pixSize; ...
%         0 1.6017587136/pixSize imSize(1)/2+0.0289198320/pixSize; ...
%         0 0 1];
% 
% % boresight angles and lever arm of camera4 in ladybug camera system
% Rc42lb=rotxyz([-58.8902637535 89.8498663220 13.2140110358]*pi/180);
% tc42lb=[0.018765 0.057881 0.000131]';
% K4 = [1.5951542544/pixSize, 0, imSize(2)/2-0.0049802544/pixSize; ...
%         0 1.5951542544/pixSize imSize(1)/2-0.0537794832/pixSize; ...
%         0 0 1];
% 
% % boresight angles and lever arm of camera5 in ladybug camera system
% Rc52lb=rotxyz([-0.0111726770 -0.1573915063 179.8609056717]*pi/180);
% tc52lb=[0.000209 0.000109 0.074691]';
% K5 = [1.5883893288/pixSize, 0, imSize(2)/2+0.0316760784/pixSize; ...
%         0 1.5883893288/pixSize imSize(1)/2+0.0100945896/pixSize; ...
%         0 0 1];
% 
% CAMPARAM = struct; 
% CAMPARAM(1).K = K0; CAMPARAM(2).K = K1; CAMPARAM(3).K = K2;
% CAMPARAM(4).K = K3; CAMPARAM(5).K = K4; CAMPARAM(6).K = K5;
% CAMPARAM(1).R = Rc02lb; CAMPARAM(2).R = Rc12lb; CAMPARAM(3).R = Rc22lb; 
% CAMPARAM(4).R = Rc32lb; CAMPARAM(5).R = Rc42lb; CAMPARAM(6).R = Rc52lb;
% CAMPARAM(1).t = tc02lb; CAMPARAM(2).t = tc12lb; CAMPARAM(3).t = tc22lb;
% CAMPARAM(4).t = tc32lb; CAMPARAM(5).t = tc42lb; CAMPARAM(6).t = tc52lb;

load('F:/SLAM/dataset/HighFrameRate/Test2/CAMPARAM.mat');

timeL = load('F:/SLAM/dataset/HighFrameRate/Test2/PointCloud2Timestamp.txt')*10^9;
timeC = load('F:/SLAM/dataset/HighFrameRate/Test2/frame_timestamps.txt');
Tindex = zeros(size(timeC));


for i = 1:length(timeC)
    [minVal, Tindex(i)]=min(abs(timeL-timeC(i)));
end

Tinterval=(timeL(Tindex)-timeC)/10^6;


% boresight angles and lever arm in IMU frame
Rs2i=rotxyz([178.869094016 -44.844306361 1.933645172]*pi/180);
ts2i=[0.111744 0.010389 -0.181398]';

% boresight angles and lever arm of ladybug camera center in IMU frame
Rlbs2i=rotxyz([0.15, -0.05, -179.65]*pi/180);
tlb2i=[-0.031239, 0, -0.1115382]';
Rlb2lbs=rotxyz([0, 0, 180]*pi/180);
Rlb2i=Rlbs2i*Rlb2lbs;

Rc2lbc=rotxyz([0 0 -90]*pi/180)*rotxyz([180 0 0]*pi/180);

% Save the alignment results in video
% v = VideoWriter('F:/SLAM/dataset/HighFrameRate/Test2/alignment.avi');
% open(v)

% for i = 0:0
%     cam0img = imrotate(imread(sprintf('F:/SLAM/dataset/HighFrameRate/Test2/alignment/Cam0/%06d.jpg',i)),-90);
%     cam3img = imrotate(imread(sprintf('F:/SLAM/dataset/HighFrameRate/Test2/alignment/Cam3/%06d.jpg',i)),-90);
%     cam4img = imrotate(imread(sprintf('F:/SLAM/dataset/HighFrameRate/Test2/alignment/Cam4/%06d.jpg',i)),-90);
%     h = figure();
%     h.WindowState = 'maximized';
%     montage({cam3img,cam4img,cam0img},'Size', [1 3]);
%     savename = sprintf('F:/SLAM/dataset/HighFrameRate/Test2/alignment/%06d.jpg',i);
%     saveas(h,savename)
% end

% for i = 0:716
%     frame = imread(sprintf('F:/SLAM/dataset/HighFrameRate/Test2/alignment/%06d.jpg',i));
%     writeVideo(v,frame);
% end
% close(v)

% loop over all images
for i =0:0
    
    % load velodyne points
    filename = sprintf('F:/SLAM/dataset/HighFrameRate/Test2/point_cloud/%05d.3d', Tindex(i+1)-1);
    velo=load(filename)';

    xl=rotxyz([0 0 -90]*pi/180)*velo(1:3,:);

    % Transform laser point in sensor frame to imu frame
    clearvars xi
    xi(1:3,:)=[Rs2i ts2i]*[xl;ones(1,size(velo,2))];

    % figure(2)
    % plot imu, laser senser and camera4 coordinate system
    % plot_coordinate_axis_wrt_center(gca,[0 0 0],'IMU')
    % plot_coordinate_axis_wrt_center(gca,tc42i,'LiDAR')
    % plot_coordinate_axis_wrt_center(gca,ts2i,'Cam4')
    
    % mapping 3D point cloud on 2D plane
    %Loop over all 5 camera images
    for j = 1:1
    
        % boresight angles and lever arm of camera j in ladybug camera system
        Rcj2i=Rlb2i*CAMPARAM(j).R*Rc2lbc;
        tcj2i=tlb2i+Rlb2i*CAMPARAM(j).t;

        xcj=inv(Rcj2i)*(xi-tcj2i);
        
        %         Cam0
         xcjc=[xcj(2,:);-xcj(1,:);xcj(3,:)];
        %         Cam3
%          xcjc=[xcj(2,:);xcj(3,:);xcj(1,:)];
%                 Cam4
%         xcjc=rotxyz([45 0 0]*pi/180)*[0 1 0; 0 0 -1; -1 0 0]*xcj;
        
        xcjc2 = xcjc(:,find(xcjc(3,:)>=0));
        
%         fp=figure(i*2+1)
%         scatter3(xi(1,:),xi(2,:),-xi(3,:),'.');
%         fp.WindowState = 'maximized';
%         xlabel('X')
%         ylabel('Y')
%         zlabel('Z')
%         view(0,90)  % XY
%         axis tight
%         axis([-40 20 -40 80 -5 10])
        
%         savename = sprintf('F:/SLAM/dataset/HighFrameRate/Test2/alignment/pc_%06d.jpg',i);
%         saveas(fp,savename)
                
        %get the image from camj
        imgname = sprintf('F:/SLAM/dataset/HighFrameRate/Test2/Rectified/Cam%d/%06d.png', j-1, i);
        I = imrotate(imread(imgname),0);
        
        titlename = sprintf('Cam%d', j-1);
        title(titlename)
        hold on;
    
        
        pixels = CAMPARAM(j).K*xcjc2;
        u = pixels(1,:)./pixels(3,:);
        v = pixels(2,:)./pixels(3,:);
    
        col = size(I,2) + 1;
        row = size(I,1) + 1;
        
        %range of points
        range_cam = xcjc2.*xcjc2;
        range = sqrt(sum(range_cam,1));
        [sorted_range ii_r] = sort(range);
        
        %Image points sorted with Z/range coordinate
        u = u(ii_r);
        v = v(ii_r);
        temp_min = 0.5;
        step = 1; % in meters

        index = find(u(1,:) > 1 & u(1,:) < col &  v(1,:) > 1 & v(1,:) < row); 
        X_final = u(index);
        Y_final = v(index);

        sorted = sorted_range(index);
        
        numColors = 40;
        color = hsv(numColors);
        
        for k = 1:numColors
            temp_index = find(sorted(:) >= temp_min & sorted(:) < (temp_min + step));
            temp_X_final = X_final(temp_index);
            temp_Y_final = Y_final(temp_index);
            temp_min = temp_min + step;
%             scatter(temp_X_final,temp_Y_final,2.5, color(k,:) ); 
        end
        
        hold off

%     savename = sprintf('F:/SLAM/dataset/HighFrameRate/Test2/alignment/%06d.jpg',i);
%     saveas(h,savename)

    end
    
%     Project point 3d point in the camera coordinate systme onto the panoramic image:
    panoWidth = 4096;
    panoHeight = 2048;
    
    Rcc2i=Rlb2i*Rc2lbc;
    tcc2i=tlb2i;

    xc=inv(Rcc2i)*(xi-tcc2i);
    
    xcc=[xc(2,:);-xc(1,:);xc(3,:)];
    
    hp=figure(i*2+1)
    scatter3(xc(1,:),xc(2,:),xc(3,:),'.');
    
%     bearing vector to theta phi
    theta = atan2(xcc(2,:),xcc(1,:))/pi*180 + 180;
    phi = atan2(sqrt(xcc(1,:).^2+xcc(2,:).^2),xcc(3,:))/pi*180;

%     theta phi to image coordinates
    up = panoWidth - (theta/360.0)*panoWidth;
    vp = phi/180.0*panoHeight;
    
    %get the panoramic image
    panoname = sprintf('F:/SLAM/dataset/HighFrameRate/Test2/Pano/%06d.png', i);
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
    
%     savename = sprintf('F:/SLAM/dataset/HighFrameRate/Test2/alignment/%06d.jpg',i);
%     saveas(hp,savename)
end
