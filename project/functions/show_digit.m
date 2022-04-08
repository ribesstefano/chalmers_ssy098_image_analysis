function show_digit(dataset, idx)
    i = reshape(dataset(idx,:), 28, 28)';
    % image(i);
    imshow(i);
end

