function [bboxes, bbox_list] = get_bboxes(img, box_size, stride)
    % win_size = 28;
    % stride = 5;
    n_boxes = 0;
    n_rboxes = 0;
    n_cboxes = 0;
    % Setup an array for containing all the window patches
    for r = 1:stride:size(img, 1) - box_size
        n_rboxes = n_rboxes + 1;
        for c = 1:stride:size(img, 2) - box_size
            n_boxes = n_boxes + 1;
            if r == 1
                n_cboxes = n_cboxes + 1;
            end
        end
    end
    bbox_list = zeros(box_size, box_size, 1, n_boxes); % Square boxes
    bboxes = zeros(n_boxes, 4); % M, 4 = x, y, width, height
    % Get all the bounding boxes and their content, i.e. the image pixels
    n = 1;
    background_threshold = 0;
    for r = 1:stride:size(img, 1) - box_size
        for c = 1:stride:size(img, 2) - box_size
            r_idx = r:r+box_size-1;
            c_idx = c:c+box_size-1;
            patch = img(r_idx, c_idx);
            if sum(patch ~= 0, 'all') >= background_threshold
                bbox_list(:, :, 1, n) = patch;
                bboxes(n, :) = [c, r, box_size, box_size];
                n = n + 1;
            end
        end
    end
end

