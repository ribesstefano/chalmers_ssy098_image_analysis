function [average_precision, recall, precision] = evaluate_digit_detections(digit_annotations, box_centers, box_diameters, digits, scores)
% Evaluate digit recognition performance using the average precision (AP)
% metric. The function is essentially a wrapper around the Matlab built-in
% function evaluateDetectionPrecision. Digit detections are assumed to be
% square boxes at the given center  points, and of the given diameter
% (= length of each side of the square). The number of detections is
% denoted by M. The output arguments are exactly the same as for
% evaluateDetectionPrecision. Write "help evaluateDetectionPrecision" for
% more details.
% 
% Inputs:
% digit_annotations: Table of digit annotations for one of the images. Should be a single row, and should have 10 columns (one for each digit class).
%       box_centers: Matrix of size [M 2], where each row holds the center point of a detected digit, in (x, y) order.
%     box_diameters: M-vector of
%            digits: M-vector of detected digits (each element should be one of the digits {0, 1, 2, ..., 9}).
%            scores: M-vector of confidence scores for the detections
% 
% Outputs:
% average_precision: 10-vector of AP scores, for each digit class in ascending order {0, 1, 2, ..., 9}.
%            recall: See evaluateDetectionPrecision.
%         precision: See evaluateDetectionPrecision.


% Verify input types & dimensions
assert( istable(digit_annotations) );
assert( all(size(digit_annotations) == [1 10]) );
assert( isnumeric(box_centers) );
assert( isnumeric(box_diameters) );
assert( isnumeric(digits) && all(digits == floor(digits)), 'ERROR' );
assert( isnumeric(scores) );
M = length(digits);
assert( all(size(box_centers) == [M 2]) );
assert( length(box_diameters) == M && numel(box_diameters) == M );
assert( length(digits) == M && numel(digits) == M );
assert( length(scores) == M && numel(scores) == M );

% Convert to column vectors if not already
box_diameters = reshape(box_diameters, M, 1);
digits = reshape(digits, M, 1);
scores = reshape(scores, M, 1);

% Boxes should be put on the format [x, y, width, height], where (x,y) is
% the top-left corner of the box.
box_x = box_centers(:, 1) - box_diameters/2;
box_y = box_centers(:, 2) - box_diameters/2;
box_w = box_diameters;
box_h = box_diameters;

bboxes = [box_x, box_y, box_w, box_h]; % Size [M 4]

categories = {'digit_0';'digit_1';'digit_2';'digit_3';'digit_4';'digit_5';'digit_6';'digit_7';'digit_8';'digit_9'};

detection_results = table();
detection_results.Boxes = { bboxes };
detection_results.Scores = { scores };
detection_results.Labels = { categorical(categories(digits+1), categories) };

% iou_threshold = 0.1;
iou_threshold = 0.3;
% iou_threshold = 0.5;
% iou_threshold = 0.7;
% iou_threshold = 0.9;

[average_precision, recall, precision] = evaluateDetectionPrecision(detection_results, digit_annotations, iou_threshold);

end
