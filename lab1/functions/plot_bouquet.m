function plot_bouquet(img,std)

% Computes a histogram of gaussian gradients for the image img.
% std is the standard deviation of the gaussians.

% Clear figure
clf
% Figure background white
figure('Color',[1 1 1]);
% Subplot, 1 row, 2 columns, nbr 1 is active
subplot(121)
% Draw image in active part
imagesc(img)
colormap gray
hold on
axis image

% Compute gaussian derivatives
[grad_x, grad_y] = gaussian_gradients(img,std);

% Plot gradients in red with thicker lines
% quiver(grad_x,grad_y,'r','LineWidth',2)

% Compute histogram
histogram = gradient_histogram(grad_x, grad_y);


% Set second subplot as active
subplot(122)
hold on
% No coordinate axes
axis off


% Compute central angles for the eight histogram bins
angles = pi/8 + (0:1:7)*pi/4;
% Variable to determine a good size for the plot window
max_val = 0.1;
% Plot a vector of the right length for each bin
gradcolors{1} = [216 139 77]/255;
gradcolors{2} = [88 160 97]/255;
gradcolors{3} = [84 136 201]/255;
gradcolors{4} = [242 218 100]/255;
gradcolors{5} = [173 143 74]/255;
gradcolors{6} = [0 0 0];
gradcolors{7} = [145 110 175]/255;
gradcolors{8} = [198 95 71]/255;
for kk = 1:8
    vec = histogram(kk)*[cos(angles(kk)) sin(angles(kk))]; 
    quiver(0, 0, vec(1), vec(2),'Color', gradcolors{kk} ,'LineWidth',2)
    
    max_val = max(max_val, max(abs(vec)));
end

% We want coordinate axes to point as they do for images
set (gca,'Ydir','reverse')
axis image
% Set plot window size
axis([-max_val max_val -max_val max_val])

% Plot some guiding lines.
plot([-max_val max_val], [0, 0], 'k:')
plot([0, 0], [-max_val max_val], 'k:')

