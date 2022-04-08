function fcn = fcn_model()
    fcn = [
                imageInputLayer([28 28 1], 'Normalization', 'none');
                % conv1
                convolution2dLayer(5, 128, 'Padding', 'same');
                reluLayer();
                maxPooling2dLayer(2, 'Stride', 2);
                % conv2
                convolution2dLayer(5, 64);
                reluLayer();
                maxPooling2dLayer(2, 'Stride', 2);
                % conv3
                convolution2dLayer(5, 10); %, 'Padding', 'same', 'Stride', 2);
                softmaxLayer();
                pixelClassificationLayer()
            ];
end

% Working solution:
%
% fcn = [
%     imageInputLayer([28 28 1], 'Normalization', 'none');
%     % conv1
%     convolution2dLayer(5, 128, 'Padding', 'same');
%     reluLayer();
%     maxPooling2dLayer(2, 'Stride', 2);
%     % conv2
%     convolution2dLayer(5, 64);
%     reluLayer();
%     maxPooling2dLayer(2, 'Stride', 2);
%     % conv3
%     convolution2dLayer(5, 10); %, 'Padding', 'same', 'Stride', 2);
%     softmaxLayer();
%     pixelClassificationLayer()
% ];