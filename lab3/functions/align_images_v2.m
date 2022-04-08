function warped = align_images_v2(source, target, threshold, upright, n_samples)
    if nargin < 5
        n_samples = 20;
    end
    [pts_src, descs_src] = extractSIFT(source, upright);
    [pts_tgt, descs_tgt] = extractSIFT(target, upright);
    corrs = matchFeatures(descs_src', descs_tgt', 'MaxRatio', 0.8, 'MatchThreshold', 100);
    pts_src = pts_src(:, corrs(:, 1));
    pts_tgt = pts_tgt(:, corrs(:, 2));
    [A, t] = ransac_fit_affine(pts_src, pts_tgt, threshold, n_samples);
    warped = affine_warp(size(target), source, A, t);
end

