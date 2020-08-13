# MaverickProjectLidar2Image
**Author:** Yujia Zhang

**Main page of our group:** [AUSM Lab](https://gunhosohn.me/)

## Main description
This is a Matlab script that projects the lidar 3d point cloud onto the panoramic image for the [Maverick Mobile Mapping System](http://www.teledyneoptech.com/en/products/mobile-survey/maverick/).
The calibration estimates the intrinsics of the ladybug camera, the boresight and level-arm parameters between lidar and ladybug camera. 

## Example
Input: calibration parameters, timestamps for lidar 3d point cloud and panoramic image, the lidar 3d point cloud, the single image from camera j or panoramic image

```
    load('F:/SLAM/dataset/HighFrameRate/Test2/CAMPARAM.mat');

    timeL = load('F:/SLAM/dataset/HighFrameRate/Test2/PointCloud2Timestamp.txt')*10^9;
    timeC = load('F:/SLAM/dataset/HighFrameRate/Test2/frame_timestamps.txt');

    ////////////////////////////////////////////////

    % load velodyne points
    filename = sprintf('F:/SLAM/dataset/HighFrameRate/Test2/point_cloud/%05d.3d', Tindex(i+1)-1);

    ////////////////////////////////////////////////

    %get the image from camj
    imgname = sprintf('F:/SLAM/dataset/HighFrameRate/Test2/Rectified/Cam%d/%06d.png', j-1, i);
    ////////////////////////////////////////////////
    %get the panoramic image
    panoname = sprintf('F:/SLAM/dataset/HighFrameRate/Test2/Pano/%06d.png', i);

```

Output: the panoramic image mapped with lidar 3d point cloud, the colors represent the depth range

