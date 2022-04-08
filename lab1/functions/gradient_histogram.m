function histogram = gradient_histogram(grad_x, grad_y)
    num_bins = 8;
    histogram = 1:num_bins;
    angles = atan2(grad_y, grad_x);
    for n = 1:num_bins
        % Get the interval extremes each angle belongs to.
        % NOTE: atan2 returns values between -pi and pi, but we need them to be
        % between 0 and 1.
        low_end = (n-1) * 2 * pi / num_bins - pi;
        high_end = n * 2 * pi / num_bins - pi;
        % Identify the indeces corresponding to the current n-th bin.
        bin_idx = angles >= low_end & angles < high_end;
        % Get all gradients having direction corresponding to the current
        % bin.
        gx = grad_x(bin_idx);
        gy = grad_y(bin_idx);
        % NOTE: Add a correction factor to avoid having a zero norm (and so
        % divide by zero when normalizing).
        if isempty(gx)
            gx = 1e-31;
        end
        if isempty(gy)
            gy = 1e-31;
        end
        % Get the gradient magnitude, i.e. L-2 norm.
        % NOTE: A 'flat' histogram would happen in case of a completely
        % white patch, for istance.
        % NOTE: All gradients belonging to the current bin, i.e. all having
        % the same direction, are summed together.
        magnitudes = sqrt(gx.^2 + gy.^2);
        histogram(n) = sum(magnitudes, 'all');
    end
    if ~all(histogram(:) == 0)
        histogram = histogram / norm(histogram);
    else
        % It shouldn't happen though...
        disp(['WARNING. Histogram is all zeros: ' num2str(histogram)])
    end
end