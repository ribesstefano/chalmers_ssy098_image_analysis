function value = sample_image_at(img, position)
    y = int32(round(position(1)));
    x = int32(round(position(2)));
    if (x <= 0) || (x > size(img, 2))
        value = 1;
    elseif (y <= 0) || (y > size(img, 1))
        value = 1;
    else
        value = img(y, x);
    end
end

