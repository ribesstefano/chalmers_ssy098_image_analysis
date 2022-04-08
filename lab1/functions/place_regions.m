function region_centres = place_regions(centre, radius)
    region_centres = [9, 2];
    for m = -1:1
        for n = -1:1
            idx = m * 3 + n + 5;
            x = centre(1) + m * radius;
            y = centre(2) + n * radius;
            region_centres(idx, :) = [x, y];
        end
    end
    region_centres = region_centres';
end