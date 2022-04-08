function img = read_image(path_to_file, as_grayscale)
    if nargin < 2
        as_grayscale = false;
    end
    % Read RGB image from path and return real values.
    raw_img = imread(path_to_file);
    img = im2double(raw_img);
    if as_grayscale
        img = mean(img, 3);
    end
end