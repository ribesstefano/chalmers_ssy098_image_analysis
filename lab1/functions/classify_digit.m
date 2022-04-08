function label = classify_digit(digit_image, digits_training, radius, position)
    if nargin < 3
        % Compute the largest sub-region radius given the image size.
        min_dim = min(size(digit_image));
        radius = double(int32(min_dim / 3 - 1) / 2);
    else
        radius = double(int32(radius));
    end
    if nargin < 4
        x = int32(size(digit_image, 1) / 2);
        y = int32(size(digit_image, 2) / 2);
        position = [x; y];
    end
    desc_in = gradient_descriptor(digit_image, position, radius);
    idx_best = 1;
    min_dist = inf;
    for n = 1:length(digits_training)
        dist = mean((digits_training(n).descriptor - desc_in).^2);
        if dist < min_dist
            idx_best = n;
            min_dist = dist;
        end
    end
    label = digits_training(idx_best).label;
end