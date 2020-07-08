% 2020/02/10
% Jungwon Kang

% <parameters>
%  610007_boresight.lcp
%  unit7_boresightLB.ccp


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
ex = -179.589305*(pi/180);
ey =  -44.644867*(pi/180);
ez =   -0.613527*(pi/180);
tx =  0.1228;
ty =  0.0068;
tz = -0.1814;

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
ex =   0.9748000000*(pi/180);
ey =  -0.1090000000*(pi/180);
ez = 178.9062000000*(pi/180);
tx = -0.0300000000;
ty = -0.0088000000;
tz = -0.1030000000;

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
ex = -131.1566283030*(pi/180);
ey =   89.9317992867*(pi/180);
ez = -131.1566283030*(pi/180);

if b_use_real_value == 1
    tx =  0.0604850000;
    ty =  0.0001650000;
    tz = -0.0000360000;
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
ex = -101.0205952691*(pi/180);
ey =   89.7734337521*(pi/180);
ez = -172.8315156673 *(pi/180);

if b_use_real_value == 1
    tx =  0.0190600000;
    ty = -0.0574770000;
    tz =  0.0003030000;
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
ex = -97.5597010038*(pi/180);
ey =  89.9027503265*(pi/180);
ez = 118.4063693065*(pi/180);

if b_use_real_value == 1
    tx = -0.0491990000;
    ty = -0.0360350000;
    tz = -0.0000720000;
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
ex = -114.3748663731*(pi/180);
ey =   89.8860199588*(pi/180);
ez =   29.1952363344*(pi/180);

if b_use_real_value == 1
    tx = -0.0490060000;
    ty =  0.0357690000;
    tz = -0.0002170000;
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
ex = -76.7269555756*(pi/180);
ey =  89.6320277683*(pi/180);
ez =  -4.7173907098*(pi/180);

if b_use_real_value == 1
    tx = 0.0186600000;
    ty = 0.0575770000;
    tz = 0.0000220000;
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
ex =   0.0328877774*(pi/180);
ey =  -0.1499430550*(pi/180);
ez = 179.3679327848*(pi/180);

if b_use_real_value == 1
    tx = -0.0000850000;
    ty =  0.0002770000;
    tz =  0.0747960000;
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
%visualize_coordframe(mat_rot_camcen_in_world, mat_trans_camcen_in_world, stt_vis, 'CC');
 
% %%%% draw coord-frame (camX)
visualize_coordframe(mat_rot_cam0_in_world, mat_trans_cam0_in_world, stt_vis, 'Cam0');
visualize_coordframe(mat_rot_cam1_in_world, mat_trans_cam1_in_world, stt_vis, 'Cam1');
visualize_coordframe(mat_rot_cam2_in_world, mat_trans_cam2_in_world, stt_vis, 'Cam2');
visualize_coordframe(mat_rot_cam3_in_world, mat_trans_cam3_in_world, stt_vis, 'Cam3');
visualize_coordframe(mat_rot_cam4_in_world, mat_trans_cam4_in_world, stt_vis, 'Cam4');
visualize_coordframe(mat_rot_cam5_in_world, mat_trans_cam5_in_world, stt_vis, 'Cam5');  % top cam









