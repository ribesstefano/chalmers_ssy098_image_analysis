function warped = affine_warp(target_imsize, source, A, t)

% warped = affineWarp(target_imsize, source, A, t)

% Matlab will invert the matrix, so for you to see what really happens,
% I uninvert it first.
T = ([A t; 0 0 1]);
aff_T = affine2d(T');

% Tell Matlab the size and placement of the output
output_view = imref2d(target_imsize);

% And, finally (!), perform the warping
warped = imwarp(source, aff_T, 'OutputView', output_view);
