function img = read_image(path_to_file)
    % Read RGB image from path and return real values.
    raw_img = imread(path_to_file);
    img = im2double(raw_img);
end