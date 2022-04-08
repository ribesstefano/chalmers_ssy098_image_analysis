function [U, nbr_inliers] = ransac_triangulation(Ps, us, threshold, n_samples, verbose)
    U = zeros(3, size(Ps, 1));
    nbr_inliers = 0;
    if nargin < 4
        n_samples = 2;
    end
    if nargin < 5
        verbose = 0;
    end
    probability = 0.99;
    max_trials = 100;
    hard_limit = 2e5; % Avoid infinite loop and set an absolute max value
    n_trials = 0;
    n_inliers_best = 1;
    best_residuals = 0; % For logging porpuses
    while n_trials < max_trials && n_trials < hard_limit
        n_trials = n_trials + 1;
        % Get random indexes
        idx_range = linspace(1, length(Ps), length(Ps));
        rand_idx = datasample(idx_range, n_samples, 'Replace', false);
        % Sample using the random indexes
        sample_Ps = Ps(rand_idx);
        sample_us = us(:, rand_idx);
        % Run a minimal solver
        U_min = minimal_triangulation(sample_Ps, sample_us);
        % Estimate the residuals based on the argument threshold
        residuals = reprojection_errors(Ps, us, U_min);
        % Finally, count the inliers and if better, update the estimates
        n_inliers = nnz(residuals <= threshold);
        if n_inliers > n_inliers_best
            n_inliers_best = n_inliers;
            U = U_min;
            nbr_inliers = n_inliers_best;
            % Update iteration number
            eps = n_inliers / length(Ps);
            max_trials = get_max_trials(probability, eps, n_samples);
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

