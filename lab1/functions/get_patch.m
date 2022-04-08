function patch = get_patch(image, x, y, patch_radius)
    x_coords = x - patch_radius : x + patch_radius;
    y_coords = y - patch_radius : y + patch_radius;
    if any(x_coords <= 0) | any(y_coords <= 0)
        patch = 'ERROR. Patch outside image border';
        disp(['ERROR. Patch outside image border ' num2str(x_coords) ', ' num2str(y_coords)])
        return;
    end
    if any(x_coords > size(image, 2)) | any(y_coords > size(image, 1))
        patch = 'ERROR. Patch outside image border';
        disp(['ERROR. Patch outside image border ' num2str(x_coords) ', ' num2str(y_coords)])
        return;
    end
    patch = image(y_coords, x_coords);
end