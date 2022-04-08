load sequence.mat
thr = 10;
Us = [];
n_examples = int32(length(triangulation_examples) * 0.8);
disp(['DEBUG. Processing ' num2str(n_examples) ' examples over ' num2str(length(triangulation_examples)) ' available.'])
for n = 1:n_examples
    Ps = triangulation_examples(n).Ps;
    xs = triangulation_examples(n).xs;
    n_samples = min(2, length(Ps));
    [U, nbr_inliers] = ransac_triangulation(Ps, xs, thr, n_samples);
    if nbr_inliers >= 2
        Us = [Us U];
    end
    if mod(n, int32(n_examples * 0.1)) == 0
        perc_progress = ceil(double(n) / double(n_examples) * 100.0);
        disp(['DEBUG. ' num2str(perc_progress) '% iterations completed. Inliers: ' num2str(nbr_inliers)])
    end
end
disp(['INFO. Number of 3D inlier points found: ' num2str(length(Us))])