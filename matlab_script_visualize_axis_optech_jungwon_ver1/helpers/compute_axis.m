% 2020/02/09
% compute axis
%   vec_X_axis_current: axis for displaying current axis
%   vec_X_axis_past: axis for displaying past axis


function [Vec_x_axis, Vec_y_axis, Vec_z_axis] = compute_axis(Length_axis, Mat_body_rot, Mat_body_trans)

% Mat_body_trans: (1 x 3)

      
%%%% set seed axis vectors
seed_vec_x_axis_ = [Length_axis, 0.0, 0.0];
seed_vec_y_axis_ = [0.0, Length_axis, 0.0];
seed_vec_z_axis_ = [0.0, 0.0, Length_axis];


%%%% rotate it by mat_rot
seed_vec_x_axis = Mat_body_rot*seed_vec_x_axis_';
seed_vec_y_axis = Mat_body_rot*seed_vec_y_axis_';
seed_vec_z_axis = Mat_body_rot*seed_vec_z_axis_';


%%%% translate vectors to camera position. Make the vectors for plotting    
Vec_x_axis(1,1:3) = Mat_body_trans;
Vec_y_axis(1,1:3) = Mat_body_trans;
Vec_z_axis(1,1:3) = Mat_body_trans;

Vec_x_axis(2,:) = Mat_body_trans + seed_vec_x_axis';
Vec_y_axis(2,:) = Mat_body_trans + seed_vec_y_axis';
Vec_z_axis(2,:) = Mat_body_trans + seed_vec_z_axis';



