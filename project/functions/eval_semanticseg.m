function [average_precision, recall, precision] = eval_semanticseg(...
        digit_annotations, eval_bboxes, eval_scores, eval_labels)
    categories = {'digit_0';'digit_1';'digit_2';'digit_3';'digit_4';'digit_5';'digit_6';'digit_7';'digit_8';'digit_9'};
    categories = categorical(categories(eval_labels+1), categories);
    detection_results = table();
    detection_results.Boxes = {eval_bboxes};
    detection_results.Scores = {eval_scores};
    detection_results.Labels = {categories};
    % iou_threshold = 0.1;
    iou_threshold = 0.3;
    % iou_threshold = 0.5;
    % iou_threshold = 0.7;
    % iou_threshold = 0.9;
    [average_precision, recall, precision] = ...
        evaluateDetectionPrecision(detection_results, ...
                                   digit_annotations, iou_threshold);
end

