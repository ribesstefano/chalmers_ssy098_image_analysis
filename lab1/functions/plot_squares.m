function plot_squares(img, centres, radius)

% plotSquares plots the squares indicated by centres and the radius in
% the image img.
% centres - 2xn array of centre coordinates
% halfwidths 1xn array of square halfsize. The squares will have size
% (2*halfwidths + 1) x (2*halfwidths + 1)

% Clear plot window
clf
% Draw image
imagesc(img)
axis image
colormap gray
hold on

nbr_squares = size(centres,2);

for kk = 1:nbr_squares    
    col_vals = centres(1,kk) + radius*[-1  1  1 -1 -1];
    row_vals = centres(2,kk) + radius*[-1 -1  1  1 -1];
    plot(col_vals, row_vals, 'Color', [1 0.5 0], 'LineWidth', 2);
end

axis([1 size(img,2) 1 size(img,1)])