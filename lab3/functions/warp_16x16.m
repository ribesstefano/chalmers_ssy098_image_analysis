function warped = warp_16x16(source)
    warped = zeros(16, 16);
    for m = 1:16
        for n = 1:16
            tgt_coords = [m; n];
            src_coords = transform_coordinates(tgt_coords);
            src_coords = [src_coords(2), src_coords(1)];
            warped(n, m) = sample_image_at(source, src_coords);
        end
    end
end