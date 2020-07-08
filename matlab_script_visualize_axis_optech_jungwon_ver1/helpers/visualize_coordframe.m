% 2020/02/09
% Jungwon Kang

function visualize_coordframe(mat_rot, mat_trans, stt_vis, str_text)

% mat_rot: (3 x 3)
% mat_trans: (3 x 1)
% stt_vis: params for visualization

[vec_x_axis, ...
 vec_y_axis, ...
 vec_z_axis] = compute_axis(stt_vis.length_axis, mat_rot, mat_trans');

arrow3(vec_x_axis(1,:), vec_x_axis(2,:), stt_vis.option_arrow_axis_x, stt_vis.style_arrow_this_w, stt_vis.style_arrow_this_h, stt_vis.style_arrow_this_ip);
arrow3(vec_y_axis(1,:), vec_y_axis(2,:), stt_vis.option_arrow_axis_y, stt_vis.style_arrow_this_w, stt_vis.style_arrow_this_h, stt_vis.style_arrow_this_ip);
arrow3(vec_z_axis(1,:), vec_z_axis(2,:), stt_vis.option_arrow_axis_z, stt_vis.style_arrow_this_w, stt_vis.style_arrow_this_h, stt_vis.style_arrow_this_ip);

text(mat_trans(1) + 0.02, mat_trans(2) + 0.02, mat_trans(3) + 0.01, str_text);

% text(mat_trans(1) + 0.02, mat_trans(2) + 0.02, mat_trans(3) - 0.01, str_text, ...
%      'BackgroundColor', [0.9, 0.9, 0.9]);





end
