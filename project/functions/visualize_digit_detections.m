function visualize_digit_detections(observed_image, digit_annotations, box_centers, box_diameters, digits, scores)
% Visualize digit recognition performance. Digit detections are assumed to be
% square boxes at the given center points, and of the given diameter
% (= length of each side of the square). The number of detections is
% denoted by M. Matching between detected digits and ground truth digits is
% carried out consistently with the AP evaluation metric computation (see
% functions evaluate_digit_detections and evaluateDetectionPrecision). If a
% digit detection is considered a correct match with an annotated digit, a green
% box is plotted, otherwise a red one. A label shows the predicted class and
% confidence score.
% 
% Inputs:
%    observed_image: Image for which to plot evaluated box predictions.
% digit_annotations: Table of digit annotations for one of the images. Should be a single row, and should have 10 columns (one for each digit class).
%       box_centers: Matrix of size [M 2], where each row holds the center point of a detected digit, in (x, y) order.
%     box_diameters: M-vector of
%            digits: M-vector of detected digits (each element should be one of the digits {0, 1, 2, ..., 9}).
%            scores: M-vector of confidence scores for the detections
% 

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
% detection_results.Boxes = { [502,374,22,23;   852,324,74,81] };
% detection_results.Scores = { [0.3;  0.9] };
% detection_results.Labels = { categorical(categories([1; 6]+1), categories) };
detection_results.Boxes = { bboxes };
detection_results.Scores = { scores };
detection_results.Labels = { categorical(categories(digits+1), categories) };

% iou_threshold = 0.1;
iou_threshold = 0.3;
% iou_threshold = 0.5;
% iou_threshold = 0.7;
% iou_threshold = 0.9;

% Preprocessing of detections & annotations, building a so-called "datastore" of each.
boxFormat = 4; % axis-aligned
[gtds, classes] = vision.internal.detector.evaluationInputValidation(detection_results, ...
    digit_annotations, mfilename, true, boxFormat, iou_threshold);
resultds = iDetectionResultsDatastore(detection_results,classes);

% Match the detection results with ground truth
s = vision.internal.detector.evaluateDetection(resultds, gtds, iou_threshold, classes);

figure;
imshow(observed_image);
hold on;
for c = 1:numel(classes)
%     s(c).labels denote FG (1) vs BG (0), i.e. whether the detection was or
%     was not matched to a GT box, with the correct class prediction.
    matched_and_correct = s(c).labels == 1;

    assert( classes(c) == "digit_"+num2str(c-1) );
    if sum(matched_and_correct) > 0
        viz_label = "#" + string(num2str(c-1)) + ": " + string(num2str(s(c).scores(matched_and_correct), '%.3f'));
        showShape('rectangle', round(s(c).Detections( matched_and_correct, : )), 'Label', viz_label, 'Color', 'green');
    end
    if sum(~matched_and_correct) > 0
        viz_label = "#" + string(num2str(c-1)) + ": " + string(num2str(s(c).scores(~matched_and_correct), '%.3f'));
        showShape('rectangle', round(s(c).Detections( ~matched_and_correct, : )), 'Label', viz_label, 'Color', 'red');
    end
end
hold off;

end

%--------------------------------------------------------------------------
function ds = iDetectionResultsDatastore(results,classname)
if size(results,2) == 2
    % Results has bbox and scores. Add labels. This standardizes the
    % datastore read output to [bbox, scores, labels] and make downstream
    % computation simpler.
    addScores = false;
    addLabels = true;
else
    addScores = false;
    addLabels = false;
end
ds = vision.internal.detector.detectionResultsTableToDatastore(results,addScores,addLabels,classname);
end
