% 2020/02/10
% Jungwon Kang

% <parameters>
%  6100012_CCP.ccp
%  6100012_LCP.lcp


clc;
clear all;
close all;

addpath( genpath('./helpers') );
addpath( genpath('./lib_arrow3') );


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% set coord-frames
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%--------------------------------------------------------------------------------------------------------------------------------
%%% imu (origin)
%%%--------------------------------------------------------------------------------------------------------------------------------
mat_rot_imu_in_world = rot_x(pi);
mat_trans_imu_in_world = zeros(3, 1);
[hmat_imu_in_world] = convert_rot_trans_to_homo(mat_rot_imu_in_world, mat_trans_imu_in_world);


%%%--------------------------------------------------------------------------------------------------------------------------------
%%% lidar
%%%--------------------------------------------------------------------------------------------------------------------------------
ex = 178.869094016*(pi/180);
ey =  -44.844306361*(pi/180);
ez =   1.933645172*(pi/180);
tx =  0.111744;
ty =  0.010389;
tz = -0.181398;

%%% delta
mat_rot_lidar_in_imu = rot_z(ez)*rot_y(ey)*rot_x(ex);
mat_trans_lidar_in_imu = [tx; ty; tz];
[hmat_lidar_in_imu] = convert_rot_trans_to_homo(mat_rot_lidar_in_imu, mat_trans_lidar_in_imu);

%%% in world
hmat_lidar_in_world = hmat_imu_in_world*hmat_lidar_in_imu;
[mat_rot_lidar_in_world, mat_trans_lidar_in_world] = convert_homo_to_rot_trans(hmat_lidar_in_world);



%%%--------------------------------------------------------------------------------------------------------------------------------
%%% camcen
%%%--------------------------------------------------------------------------------------------------------------------------------
ex =   0.150000*(pi/180);
ey =  -0.050000*(pi/180);
ez = -179.650000*(pi/180);
tx = -0.0312390000;
ty =  0.0000000000;
tz = -0.1115382000;

%%% delta
mat_rot_camcen_in_imu = rot_z(ez)*rot_y(ey)*rot_x(ex)*rot_x(pi);
mat_trans_camcen_in_imu = [tx; ty; tz];
% [mat_rot_camcen_in_imu, mat_trans_camcen_in_imu] = make_mat_rot_trans(ex, ey, ez, tx, ty, tz);
[hmat_camcen_in_imu] = convert_rot_trans_to_homo(mat_rot_camcen_in_imu, mat_trans_camcen_in_imu);

%%% in world
hmat_camcen_in_world = hmat_imu_in_world*hmat_camcen_in_imu;
[mat_rot_camcen_in_world, mat_trans_camcen_in_world] = convert_homo_to_rot_trans(hmat_camcen_in_world);



%%%--------------------------------------------------------------------------------------------------------------------------------
%%% common for camX
%%%--------------------------------------------------------------------------------------------------------------------------------
tx = 0.0;
ty = 0.0;
tz = 0.0;

b_use_real_value = 1;

%%%--------------------------------------------------------------------------------------------------------------------------------
%%% cam0
%%%--------------------------------------------------------------------------------------------------------------------------------
ex = 57.2627198408*(pi/180);
ey = 89.7638080612*(pi/180);
ez = 57.2629490239*(pi/180);

if b_use_real_value == 1
    tx =  0.0608470000;
    ty = -0.0001300000;
    tz =  0.0000000000;
end

%%% delta
% mat_rot_cam0_in_camcen = rot_z(ez)*rot_y(ey)*rot_x(ex);
% mat_trans_cam0_in_camcen = [tx; ty; tz];
[mat_rot_cam0_in_camcen, mat_trans_cam0_in_camcen] = make_mat_rot_trans(ex, ey, ez, tx, ty, tz);
[hmat_cam0_in_camcen] = convert_rot_trans_to_homo(mat_rot_cam0_in_camcen, mat_trans_cam0_in_camcen);

%%% in world
hmat_cam0_in_world = hmat_camcen_in_world*hmat_cam0_in_camcen;
[mat_rot_cam0_in_world, mat_trans_cam0_in_world] = convert_homo_to_rot_trans(hmat_cam0_in_world);



%%%--------------------------------------------------------------------------------------------------------------------------------
%%% cam1
%%%--------------------------------------------------------------------------------------------------------------------------------
ex = -50.8820899477*(pi/180);
ey =  89.6812448429*(pi/180);
ez = -122.8274262447*(pi/180);

if b_use_real_value == 1
    tx =  0.0188850000;
    ty = -0.0577570000;
    tz =  0.0002620000;
end
    
%%% delta
%mat_rot_cam1_in_camcen = rot_z(ez)*rot_y(ey)*rot_x(ex);
%mat_trans_cam1_in_camcen = [tx; ty; tz];
[mat_rot_cam1_in_camcen, mat_trans_cam1_in_camcen] = make_mat_rot_trans(ex, ey, ez, tx, ty, tz);
[hmat_cam1_in_camcen] = convert_rot_trans_to_homo(mat_rot_cam1_in_camcen, mat_trans_cam1_in_camcen);

%%% in world
hmat_cam1_in_world = hmat_camcen_in_world*hmat_cam1_in_camcen;
[mat_rot_cam1_in_world, mat_trans_cam1_in_world] = convert_homo_to_rot_trans(hmat_cam1_in_world);


%%%--------------------------------------------------------------------------------------------------------------------------------
%%% cam2
%%%--------------------------------------------------------------------------------------------------------------------------------
ex = -14.1254722962*(pi/180);
ey =  89.9377007520*(pi/180);
ez = -158.1394454076*(pi/180);

if b_use_real_value == 1
    tx = -0.0492490000;
    ty = -0.0355960000;
    tz = -0.0002360000;
end

%%% delta
% mat_rot_cam2_in_camcen = rot_z(ez)*rot_y(ey)*rot_x(ex);
% mat_trans_cam2_in_camcen = [tx; ty; tz];
[mat_rot_cam2_in_camcen, mat_trans_cam2_in_camcen] = make_mat_rot_trans(ex, ey, ez, tx, ty, tz);
[hmat_cam2_in_camcen] = convert_rot_trans_to_homo(mat_rot_cam2_in_camcen, mat_trans_cam2_in_camcen);

%%% in world
hmat_cam2_in_world = hmat_camcen_in_world*hmat_cam2_in_camcen;
[mat_rot_cam2_in_world, mat_trans_cam2_in_world] = convert_homo_to_rot_trans(hmat_cam2_in_world);


%%%--------------------------------------------------------------------------------------------------------------------------------
%%% cam3
%%%--------------------------------------------------------------------------------------------------------------------------------
ex = -122.1097966064*(pi/180);
ey =   89.8767380426*(pi/180);
ez =   22.1840663879*(pi/180);

if b_use_real_value == 1
    tx = -0.0492470000;
    ty =  0.0356020000;
    tz = -0.0001570000;
end

%%% delta
% mat_rot_cam3_in_camcen = rot_z(ez)*rot_y(ey)*rot_x(ex);
% mat_trans_cam3_in_camcen = [tx; ty; tz];
[mat_rot_cam3_in_camcen, mat_trans_cam3_in_camcen] = make_mat_rot_trans(ex, ey, ez, tx, ty, tz);
[hmat_cam3_in_camcen] = convert_rot_trans_to_homo(mat_rot_cam3_in_camcen, mat_trans_cam3_in_camcen);

%%% in world
hmat_cam3_in_world = hmat_camcen_in_world*hmat_cam3_in_camcen;
[mat_rot_cam3_in_world, mat_trans_cam3_in_world] = convert_homo_to_rot_trans(hmat_cam3_in_world);


%%%--------------------------------------------------------------------------------------------------------------------------------
%%% cam4
%%%--------------------------------------------------------------------------------------------------------------------------------
ex = -58.8902637535*(pi/180);
ey =  89.8498663220*(pi/180);
ez =  13.2140110358*(pi/180);

if b_use_real_value == 1
    tx = 0.0187650000;
    ty = 0.0578810000;
    tz = 0.0001310000;
end

%%% delta
% mat_rot_cam4_in_camcen = rot_z(ez)*rot_y(ey)*rot_x(ex);
% mat_trans_cam4_in_camcen = [tx; ty; tz];
[mat_rot_cam4_in_camcen, mat_trans_cam4_in_camcen] = make_mat_rot_trans(ex, ey, ez, tx, ty, tz);
[hmat_cam4_in_camcen] = convert_rot_trans_to_homo(mat_rot_cam4_in_camcen, mat_trans_cam4_in_camcen);

%%% in world
hmat_cam4_in_world = hmat_camcen_in_world*hmat_cam4_in_camcen;
[mat_rot_cam4_in_world, mat_trans_cam4_in_world] = convert_homo_to_rot_trans(hmat_cam4_in_world);


%%%--------------------------------------------------------------------------------------------------------------------------------
%%% cam5
%%%--------------------------------------------------------------------------------------------------------------------------------
ex =  -0.0111726770*(pi/180);
ey =  -0.1573915063*(pi/180);
ez = 179.8609056717*(pi/180);

if b_use_real_value == 1
    tx = 0.0002090000;
    ty = 0.0001090000;
    tz = 0.0746910000;
end

%%% delta
% mat_rot_cam5_in_camcen = rot_z(ez)*rot_y(ey)*rot_x(ex);
% mat_trans_cam5_in_camcen = [tx; ty; tz];
[mat_rot_cam5_in_camcen, mat_trans_cam5_in_camcen] = make_mat_rot_trans(ex, ey, ez, tx, ty, tz);
[hmat_cam5_in_camcen] = convert_rot_trans_to_homo(mat_rot_cam5_in_camcen, mat_trans_cam5_in_camcen);

%%% in world
hmat_cam5_in_world = hmat_camcen_in_world*hmat_cam5_in_camcen;
[mat_rot_cam5_in_world, mat_trans_cam5_in_world] = convert_homo_to_rot_trans(hmat_cam5_in_world);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% visualize coord-frames
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%--------------------------------------------------------------------------------------------------------------------------------
%%% load params for visualization
%%%--------------------------------------------------------------------------------------------------------------------------------
[stt_vis] = load_params_visualization();


%%%--------------------------------------------------------------------------------------------------------------------------------
%%% draw
%%%--------------------------------------------------------------------------------------------------------------------------------
h_fig = figure(1);

set(h_fig, 'Position', [stt_vis.pos_fig_left, stt_vis.pos_fig_bottom, stt_vis.pos_fig_width, stt_vis.pos_fig_height]);
set(h_fig, 'Color', [1 1 1]);

daspect([1 1 1])    % for arrow3
view(stt_vis.view_az, stt_vis.view_el);

grid on;
hold on;

xlabel('X', 'fontsize', 12);
ylabel('Y', 'fontsize', 12);
zlabel('Z', 'fontsize', 12);
% title('Coord Frame', 'fontsize',16);

axis equal;
axis([stt_vis.x_axis_min, stt_vis.x_axis_max, stt_vis.y_axis_min, stt_vis.y_axis_max, stt_vis.z_axis_min, stt_vis.z_axis_max]);
camlight left;


%%%% draw coord-frame (imu)
visualize_coordframe(mat_rot_imu_in_world, mat_trans_imu_in_world, stt_vis, 'IMU');

% %%%% draw coord-frame (lidar)
visualize_coordframe(mat_rot_lidar_in_world, mat_trans_lidar_in_world, stt_vis, 'LiDAR');

% %%%% draw coord-frame (camcen)
% visualize_coordframe(mat_rot_camcen_in_world, mat_trans_camcen_in_world, stt_vis, 'CC');
 
% %%%% draw coord-frame (camX)
% visualize_coordframe(mat_rot_cam0_in_world, mat_trans_cam0_in_world, stt_vis, 'Cam0');
% visualize_coordframe(mat_rot_cam1_in_world, mat_trans_cam1_in_world, stt_vis, 'Cam1');
% visualize_coordframe(mat_rot_cam2_in_world, mat_trans_cam2_in_world, stt_vis, 'Cam2');
% visualize_coordframe(mat_rot_cam3_in_world, mat_trans_cam3_in_world, stt_vis, 'Cam3');
% visualize_coordframe(mat_rot_cam4_in_world, mat_trans_cam4_in_world, stt_vis, 'Cam4');
visualize_coordframe(mat_rot_cam5_in_world, mat_trans_cam5_in_world, stt_vis, 'Cam5');  % top cam









