addpath('./functions');
addpath('./data');
load digits.mat

centre = [int32(39 / 2); int32(39 / 2)];
radius = 8; % A fairly large radius that works for all training images.
for n = 1:length(digits_training)
    img = digits_training(n).image;
    digits_training(n).descriptor = gradient_descriptor(img, centre, radius);
end