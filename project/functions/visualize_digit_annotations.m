function visualize_digit_annotations(observed_image, digit_annotations)
% Visualize ground truth digit annotations. The number of digits is denoted by M.
% 
% Inputs:
%    observed_image: Image for which to plot evaluated box predictions.
% digit_annotations: Table of digit annotations for one of the images. Should be a single row, and should have 10 columns (one for each digit class).
% 

% Verify input types & dimensions
assert( istable(digit_annotations) );
assert( all(size(digit_annotations) == [1 10]) );

figure;
imshow(observed_image);
hold on;
for c = 1:10
    curr_box_annos = digit_annotations{1,c};
    curr_box_annos = curr_box_annos{1,1};
    if size(curr_box_annos, 1) > 0
        viz_label = "#" + string(num2str(c-1));
        showShape('rectangle', round(curr_box_annos), 'Label', viz_label, 'Color', 'cyan');
    end
end
hold off;

end
