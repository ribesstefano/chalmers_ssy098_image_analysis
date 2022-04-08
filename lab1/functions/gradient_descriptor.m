% - Compute gaussian gradients. Let the standard deviation be proportional to radius.
% - Divide your gradients into 3 x 3 regions defined by place_regions.
% - Compute a gradient histogram for the gradients from each region.
% - Stack the histograms into a 72-vector.
% - Normalize that vector to unit length.
function desc = gradient_descriptor(image, position, radius)
    desc = [];
    std = radius * 0.1;
    [grad_x, grad_y] = gaussian_gradients(image, std);
    for centre = place_regions(position, radius)
        patch_x = get_patch(grad_x, centre(1), centre(2), radius);
        patch_y = get_patch(grad_y, centre(1), centre(2), radius);
        if class(patch_x) == string | class(patch_y) == string
            disp(['ERROR. In creating patches. Exiting.'])
            return;
        end
        h = gradient_histogram(patch_x, patch_y);
        desc = vertcat(desc, h);
    end
    desc = desc(:);
    desc = desc / norm(desc);
end