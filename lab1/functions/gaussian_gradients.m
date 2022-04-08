function [grad_x, grad_y] = gaussian_gradients(img, std)
    filtered = gaussian_filter(img, std);
    grad_x = imfilter(filtered, 0.5 * [-1; 0; 1], 'conv');
    grad_y = imfilter(filtered, 0.5 * [-1 0 1], 'conv');
    % [grad_x, grad_y] = imgradientxy(filtered, 'central'); % Built-in function.
end