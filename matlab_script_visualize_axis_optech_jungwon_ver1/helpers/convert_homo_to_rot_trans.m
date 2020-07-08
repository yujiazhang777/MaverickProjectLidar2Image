% 2020/02/09
% Jungwon Kang

function [mat_rot, mat_trans] = convert_homo_to_rot_trans(hmat)

% convert to homogeneous matrix to rotation matrix, translation vector 
% hmat: (4 x 4)
% mat_rot: (3 x 3)
% mat_trans: (3 x 1)

mat_rot = hmat(1:3, 1:3);
mat_trans = hmat(1:3, 4);

end