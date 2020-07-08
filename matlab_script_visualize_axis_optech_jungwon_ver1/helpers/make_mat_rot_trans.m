
function [mat_rot_out, mat_trans_out] = make_mat_rot_trans(ex, ey, ez, tx, ty, tz)

% <original>
% mat_rot_out = rot_z(ez)*rot_y(ey)*rot_x(ex);
% mat_trans_out = [tx; ty; tz];


mat_rot_out = rot_z(ez)*rot_y(ey)*rot_x(ex)*(rot_z(-pi/2)*rot_x(pi));
mat_trans_out = [tx; ty; tz];


% mat_rot_out = rot_z(-ez)*rot_y(-ey)*rot_x(-ex);
% mat_trans_out = [tx; ty; tz];


% <>
% mat_rot_out = rot_z(ez)*rot_y(ey)*rot_x(ex)*rot_y(pi/2);
% mat_trans_out = [tx; ty; tz];


% mat_rot_out = rot_x(ex)*rot_y(ey)*rot_z(ez);
% mat_trans_out = [tx; ty; tz];

% mat_rot_out = rot_z(ez)*rot_y(ey)*rot_x(ex)*rot_y(pi);
% mat_trans_out = [tx; ty; tz];

% mat_rot_out = rot_z(ez)*rot_y(ey - pi)*rot_x(ex);
% mat_trans_out = [tx; ty; tz];

% mat_rot_out = rot_x(-ex)*rot_y(-ey)*rot_z(-ez);
% mat_trans_out = [tx; ty; tz];

% mat_rot_out = rot_z(-ez)*rot_y(-ey)*rot_x(-ex);
% mat_trans_out = [tx; ty; tz];



