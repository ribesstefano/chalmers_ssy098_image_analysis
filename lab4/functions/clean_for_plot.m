function [Us_clean,removed_indices] = clean_for_plot(Us)
% Removes the 1% most extreme values in each dimension.
% Us - 3xN-array with the points to clean
% Us_clean - Cleaned points.
% removed_indices - The indices of the removed points.

minvals = quantile(Us,0.01,2);
maxvals = quantile(Us,0.99,2);

removed_indices = Us(1,:) > maxvals(1,:) | Us(1,:) < minvals(1,:);
for kk = 2:3
    removed_indices = removed_indices | Us(kk,:) > maxvals(kk,:) | Us(kk,:) < minvals(kk,:);
end

Us_clean = Us(:,~removed_indices);
