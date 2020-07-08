% 2020/02/09
% Jungwon Kang

function [hmat] = convert_rot_trans_to_homo(mat_rot, mat_trans)

% convert rotation matrix, translation vector to homogeneous form
% mat_rot: (3 x 3)
% mat_trans: (3 x 1)

hmat = [mat_rot, mat_trans; zeros(1,3), 1];

end