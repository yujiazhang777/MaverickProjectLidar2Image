% 2020/02/09
% Jungwon Kang


function [stt_out] = load_params_visualization()


%%%% pos of fig
stt_out.pos_fig_left    = 100;
stt_out.pos_fig_bottom  = 100;
stt_out.pos_fig_width   = 500;
stt_out.pos_fig_height  = 500;

%%%%
stt_out.view_az = 160;
stt_out.view_el = 22;

stt_out.x_axis_min = -0.30;
stt_out.x_axis_max =  0.30;
stt_out.y_axis_min = -0.30;
stt_out.y_axis_max =  0.30;
stt_out.z_axis_min = -0.20;
stt_out.z_axis_max =  0.30;


%%%% visualization style (coord-frame)
stt_out.option_arrow_axis_x = 'r-2';
stt_out.option_arrow_axis_y = 'g-2';
stt_out.option_arrow_axis_z = 'b-2';

stt_out.style_arrow_this_w  = 1.5;
stt_out.style_arrow_this_h  = 1.5;
stt_out.style_arrow_this_ip = 0.2;

% %%%% visualization style (for current body)
% stt_out.option_arrow_current_body_x = 'b-0';
% stt_out.style_arrow_current_body_ip = 0.7;

%%%% visualization length (for axis)
stt_out.length_axis     = 0.15;




