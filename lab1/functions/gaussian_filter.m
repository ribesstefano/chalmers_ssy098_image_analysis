function filtered = gaussian_filter(img, std)
    N = double(int32(std * 4));
    if N == 0
        N = 4.0;
    end
    gfilter = fspecial('gaussian', N, std);
    filtered = imfilter(img, gfilter, 'symmetric');
end