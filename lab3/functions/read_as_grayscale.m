function img = read_as_grayscale(path_to_file)
    % Read RGB image from path and return real values.
    raw_img = read_image(path_to_file);
    img = mean(raw_img, 3);
end