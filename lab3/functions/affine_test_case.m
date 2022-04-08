function [pts, pts_tilde, A_true, t_true] = affine_test_case(num_pts, noise_magnitude)
    if nargin < 1
        num_pts = 100;
    end
    if nargin < 2
        noise_magnitude = 0;
    end
    A_true = rand(2);
    t_true = rand([2, 1]) * 10;
    pts = rand([2, num_pts]);
    pts_tilde = A_true * pts + t_true + rand([2, num_pts]) * noise_magnitude;
end