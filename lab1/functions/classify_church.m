function label = classify_church(image, feature_collection, threshold, ratio)
    if nargin < 3
        threshold = 20;
    end
    if nargin < 4
        ratio = 0.9;
    end
    label = 1;
    num_labels = length(feature_collection.names);
    matches_per_label = zeros(num_labels, 1);
    % First extract the descriptors of the input image.
    [coords, desc_in] = extractSIFT(image);
    for n = 1:num_labels
        % Extract all the training descriptors corresponding to the n-th label.
        desc = feature_collection.descriptors(:, feature_collection.labels == n);
        % NOTE: They need to be transposed in order to have the same column dim
        match_coords = matchFeatures(desc_in', desc', 'MatchThreshold', threshold, 'MaxRatio', ratio);
        % For each of the labels, store the number of matching/closest features.
        matches_per_label(n) = size(match_coords, 1);
    end
    % The final label will be the argmax of the array, i.e. the one with most
    % feature matches.
    [m, label] = max(matches_per_label);
end