function [examples_train_aug, labels_train_aug] = augment_data(examples_train, labels_train, M, scale)
    examples_train_aug = {};
    labels_train_aug = [];
    for i = 1:size(examples_train, 2)
        for j = 1:M+1
            I = cell2mat(examples_train(i));
            if nargin > 3 && scale
                % If the 'scale' argument is supplied, rotate by:
                % n * 90 + [0, 20] degrees, then scale the image to remove
                % background (black) triangles.
                angle = 90 * randi(4) + (randi([0, 20]));
            else
                % Rotate by a random multiple of 90 degrees.
                angle = 90 * randi(4);
            end
            if j ~= 1
                % NOTE: The first image remains unchanged.
                I_rot = imrotate(I, angle, 'bilinear', 'crop');
                if nargin > 3 && scale
                    width = int32(size(I, 1) * 0.7);
                    heigth = int32(size(I, 2) * 0.7);
                    xmin = (size(I, 1)-width)/2;
                    ymin = (size(I, 2)-heigth)/2;
                    I_rot = imcrop(I_rot, [xmin; ymin; width; heigth]);
                    I_rot(I_rot == 0) = mean(I, 'all');
                    I = imresize(I_rot, size(I));
                else
                    I = I_rot;
                end
            end
            if i == 2
                if j == 1
                    disp(['INFO. Original image n.' num2str(i)]), figure, colormap gray, imshow(I)
                else
                    disp(['INFO. Augmented image n.' num2str(j) ', rotated with angle: ' num2str(angle)]), figure, colormap gray, imshow(I)
                end
            end
            idx = i * M + j - M;
            examples_train_aug{idx} = I;
            labels_train_aug(idx) = labels_train(i);
        end
    end
end

