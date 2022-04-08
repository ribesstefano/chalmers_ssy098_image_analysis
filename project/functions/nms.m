function [final_boxes, final_scores, final_labels] = nms(bboxes, ...
        scores, labels, iou_threshold, scale_level_step)
    if nargin < 5
        scale_level_step = true;
    end
    if scale_level_step
        % NOTE: When considering the same scale level, there might be many
        % duplicates of the same digit, therefore remove overalpping bboxes
        % with the same label.
        [~, ~, ~, bboxes_idx] = selectStrongestBboxMulticlass(...
            bboxes, scores, labels, 'OverlapThreshold', iou_threshold);
    else
        % NOTE: When applying NMS at all scale levels, just consider the
        % bboxes with the highest confidence score.
        [~, ~, bboxes_idx] = selectStrongestBbox(bboxes, scores, ...
           'OverlapThreshold', iou_threshold);
    end
    final_boxes = bboxes(bboxes_idx, :);
    final_scores = scores(bboxes_idx);
    final_labels = labels(bboxes_idx);

%     % =====================================================================
%     % Identify the best bboxes in terms of IoU (Incorrect)
%     % =====================================================================
%     bboxes_idx = 1:size(bboxes, 1); % Set all the indexes
% 
%     % NOTE: selectStrongestBboxMulticlass is applied to the scores with the
%     % SAME LABEL.
% %     [~, ~, ~, bboxes_idx] = selectStrongestBboxMulticlass(...
% %         bboxes(bboxes_idx, :), scores(bboxes_idx), labels(bboxes_idx), ...
% %        'OverlapThreshold', iou_threshold);
% 
%     [~, ~, bboxes_idx] = selectStrongestBbox(...
%         bboxes(bboxes_idx, :), scores(bboxes_idx), ...
%        'OverlapThreshold', iou_threshold);
% 
%     % =====================================================================
%     % Implementation Notes
%     % =====================================================================
%     % The function bboxOverlapRatio() returns a matrix of IoU ratios. If
%     % applied on the boxes, it will give us the IoU of all the pairs of
%     % boxes. Naturally, the main diagonal will be all 1s since each pair
%     % perfectly overlaps with itself, whereas the overall matrix will be
%     % symmetrical. That's why we only consider the bottom half of it
%     % through the tril(..., -1) function.
%     % =====================================================================
%     % Remove the lowest-score box in overlapping box pairs
%     % =====================================================================
% %     i = 0;
% %     over_idx1 = zeros(1, 2);
% %     while ~isempty(over_idx1) || i > 64
% %         overlapping_pairs = tril(bboxOverlapRatio(bboxes, bboxes), -1);
% %         [over_idx1, over_idx2] = find(overlapping_pairs > iou_threshold);
% %         bboxes_idx = 1:size(bboxes, 1); % Set all the indexes
% %         
% %         for n = 1:length(over_idx1)
% %             % Remove lowest score indexes from all bbox indexes
% %             if scores(over_idx1(n)) < scores(over_idx2(n))
% %                 bboxes_idx = bboxes_idx(bboxes_idx ~= over_idx1(n));
% %             else
% %                 bboxes_idx = bboxes_idx(bboxes_idx ~= over_idx2(n));
% %             end
% %         end
% %         i = i + 1;
% %         bboxes = bboxes(bboxes_idx,:);
% %         scores = scores(bboxes_idx);
% %         labels = labels(bboxes_idx);
% %     end
% 
%     final_boxes = bboxes(bboxes_idx, :);
%     final_scores = scores(bboxes_idx);
%     final_labels = labels(bboxes_idx);
end

