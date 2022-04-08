function [final_boxes, final_scores, final_labels] = semanticseg_scalelevel(img, ...,
        fcn_net, box_size, stride, confidence_threshold, iou_threshold)
    % =====================================================================
    % Get all possible boxes from the image
    % =====================================================================
    [bboxes, boxes] = get_bboxes(img, box_size, stride);
    % =====================================================================
    % Get the boxes max probabilities by running the FCN
    % =====================================================================
    [~, box_class_probs] = semanticseg(boxes, fcn_net);
    [box_confidence, labels] = max(box_class_probs, [], 2);
    % NOTE: Max returns indeces, but MATLAB start indexing from 1 and our
    % labels start from 0 instead... (stupid MATLAB)...
    labels = labels - 1;
    % =====================================================================
    % Step 1: Get rid of boxes with a low confidence score, i.e. class prob
    % =====================================================================
    bboxes = bboxes(box_confidence > confidence_threshold, :);
    labels = labels(box_confidence > confidence_threshold);
    scores = box_confidence(box_confidence > confidence_threshold);
    % =====================================================================
    % Step 2: Remove the lowest-score box in overlapping box pairs
    % =====================================================================
    [final_boxes, final_scores, final_labels] = nms(bboxes, scores, ...
                                                    labels, iou_threshold);
end