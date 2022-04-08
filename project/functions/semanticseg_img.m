function [final_boxes, final_scores, final_labels] = semanticseg_img(...
        img, fcn_net, box_size, strides, downscale_levels, ...
        confidence_threshold, iou_level_threshold, iou_final_threshold)
    std = 0.8;
    norm_img = true;
    bboxes = [];
    scores = [];
    labels = [];
    % =====================================================================
    % Get bboxes at each scale level
    % =====================================================================
    for n = 1:length(downscale_levels)
        t = downscale_levels(n);
        % Slightly lower confidence threshold with scaled images
        confidence_thr = confidence_threshold - t * 0.01;
        stride = strides(n);
        img_down = downscale(img, t, std, norm_img);
        [b, s, l] = semanticseg_scalelevel(img_down, ...
                                           fcn_net, box_size, stride, ...
                                           confidence_thr, ...
                                           iou_level_threshold);
        disp(['INFO. Number of boxes found at level ' num2str(t) ': ' num2str(size(b, 1))])
        if size(b, 1) > 0
            if n == 1
                bboxes = round(b * t);
                scores = s;
                labels = l;
            else
                bboxes = vertcat(bboxes, round(b * t));
                scores = vertcat(scores, s);
                labels = vertcat(labels, l);
            end
        end
    end
    disp(['INFO. Bboxes found in scale space: ' num2str(size(bboxes, 1))])
    % =====================================================================
    % Run a final NMS round over the collected bboxes
    % =====================================================================
    [final_boxes, final_scores, final_labels] = nms(bboxes, scores, ...
                                                    labels, ...
                                                    iou_final_threshold, ...
                                                    false);
    disp(['INFO. Total boxes found: ' num2str(size(final_boxes, 1))])
end

