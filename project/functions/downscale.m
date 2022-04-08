function img_down = downscale(img, down_factor, std, normalize)
    if nargin < 3
        std = -1;
    end
    if nargin < 4
        normalize = true;
    end
    % If standard deviation is provided, smooth image before downscaling
    if std > 0
        img_tmp = gaussian_filter(img, 0.8);
    else
        img_tmp = img;
    end
    if down_factor > 1
        % Downscale
        img_down = img_tmp(1:down_factor:end, 1:down_factor:end);
    else
        % Upscale
        img_down = imresize(img_tmp, 1/down_factor, 'Antialiasing', true);
    end
    % Normalize b/w 0 and 1
    if normalize
        img_down = img_down ./ max(img_down, [], 'all');
    end
end

