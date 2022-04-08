function layers = better_cnn_classifier()
    layers = [
                imageInputLayer([28 28 1]);
                convolution2dLayer(5, 20);
                reluLayer();
                maxPooling2dLayer(2, 'Stride', 2);
                convolution2dLayer(3, 30);
                reluLayer();
                maxPooling2dLayer(2, 'Stride', 2);
                fullyConnectedLayer(100);
                reluLayer();
                fullyConnectedLayer(10);
                softmaxLayer();
                classificationLayer()
            ];
end