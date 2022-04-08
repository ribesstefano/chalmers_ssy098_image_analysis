function [pts, pts_tilde, A_true, t_true] = affine_test_case_outlier(outlier_rate, num_pts, noise_magnitude)
    if nargin < 2
        num_pts = 100;
    end
    if nargin < 3
        noise_magnitude = 0;
    end
    num_outliers = int32(num_pts * outlier_rate);
    num_pts = num_pts - num_outliers;
    [pts, pts_tilde, A_true, t_true] = affine_test_case(num_pts + num_outliers, noise_magnitude);
    low_end = -100;
    high_end = 100;
    outliers = low_end + (high_end - low_end) .* rand(2, num_outliers);
    pts_tilde = [pts_tilde(:, 1:num_pts) outliers];
end