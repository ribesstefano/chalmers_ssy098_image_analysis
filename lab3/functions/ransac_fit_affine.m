function [A, t] = ransac_fit_affine(pts, pts_tilde, threshold, n_samples, verbose)
    A = zeros(2, 2);
    t = [0, 0];
    if nargin < 4
        n_samples = 3;
    end
    if nargin < 5
        verbose = 0;
    end
    probability = 0.99;
    max_trials = 100;
    hard_limit = 2e5; % Avoid infinite loop and set an absolute max value
    n_trials = 0;
    n_inliers_best = 1;
    best_residuals = 0;
    while n_trials < max_trials && n_trials < hard_limit
        n_trials = n_trials + 1;
        % Get random indexes
        idx_range = linspace(1, length(pts), length(pts));
        rand_idx = datasample(idx_range, n_samples, 'Replace', false);
        % Sample using the random indexes
        sample_pts = pts(:, rand_idx);
        sample_pts_tilde = pts_tilde(:, rand_idx);
        % Run a minimal solver
        [A_min, t_min] = estimate_affine(sample_pts, sample_pts_tilde);
        % Estimate the residuals based on the argument threshold
        pts_pred = A_min * pts + t_min;
        residuals = sum((pts_pred - pts_tilde).^2, 1);
        % Finally, count the inliers and if better, update the estimates
        n_inliers = nnz(residuals <= threshold);
        if n_inliers > n_inliers_best
            n_inliers_best = n_inliers;
            eps = n_inliers / length(pts);
            max_trials = get_max_trials(probability, eps, n_samples);
            A = A_min;
            t = t_min;
            best_residuals = mean(residuals); % For logging porpuses
        end
    end
    if n_trials >= hard_limit && verbose
        disp('WARNING. Maximum number of iterations reached.')
    end
    if verbose
        disp(['INFO. Number of inliers: ' num2str(n_inliers_best)])
        disp(['INFO. Mean residual: ' num2str(best_residuals)])
    end
end

function k = get_max_trials(probability, eps, n)
    k = abs(int32(log(1 - probability) / log(1 - eps.^n)));
end
