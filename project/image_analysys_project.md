# Image Analysis - Project

## Notes from the description

* detection score map by taking the pixel-wise maximum across all channels -> to detect pixel vs background
* Non-maximum suppression (NMS) and thresholding to obtain digit predictions -> detect as many digits as possible, while avoiding duplicate detections of the same digit (exercise manual contains some hints on how to perform NMS in MATLAB, in particular exercise *1.16-1.19*)
* "Make sure that you can understand and keep track of which pixel in the output feature map corresponds to which position in the input image, since the dimensions of both are probably not equal." to every 28x28 patch there is a 1x1x10 output feature map (i.e. the classification itself)
* "Verify that the digits are localized in an unbiased manner - don’t forget to include the effects of stride / downsampling as well as whether or not padding is applied on the image." -> no bias?
* *Build a scale space of each observed image* <- VERY IMPORTANT: WE WANT TO RECOGNIZE DIGITS AT DIFFERENT SCALES
* Bounding boxes are squares only (no other shapes)
* In MATLAB, `pixelClassificationLayer` should be used as the final layer

> you also need to handle the possibility that the a digit is likely to be detected at more than one scale, in particular neighboring ones.
> To conclude, in one way or another you need to suppress duplicates when merging detections from the multiple scales as well.

## Notes

* Check out a well-detailed [overview](https://nanonets.com/blog/semantic-image-segmentation-2020/) (and [this one](https://nanonets.com/blog/how-to-do-semantic-segmentation-using-deep-learning/) too) on image segmentation. At the bottom, they also have nice explainations on metrics, like *Intersection Over Union (IoU)*
* Study U-Net and its characteristics (e.g. skip-connections)
* Pooling brings invariance, i.e. "_Invariance is the quality of a neural network being unaffected by slight translations in input_"
* For applying the network on dynamic size images at test time, you can use the `semanticseg` function. You can use an initial `inputImageLayer` of fixed size when you build and train your neural network - semanticseg will then let you apply the network on larger images.
* always use `imshow`!!!
* In-depth [tutorial](https://medium.com/100-shades-of-machine-learning/https-medium-com-100-shades-of-machine-learning-rediscovering-semantic-segmentation-part1-83e1462e0805) on how to tune the parameters of the U-net
* cross entropy cost function


## Steps

### Design Steps

1. Build the model: Input 28x28x1 -> Output: 1x1x10 (Loss: cross entropy cost function)
2. Detection score map: NMR + threshold?
3. [Bounding boxes](https://medium.com/analytics-vidhya/basics-of-bounding-boxes-94e583b5e16c): [YOLO (Unified Detection)](https://arxiv.org/pdf/1506.02640.pdf) Maybe? *Pytorch/OpenCV+NMS* [Tutorial](https://learnopencv.com/non-maximum-suppression-theory-and-implementation-in-pytorch/)
4. [Image pyramid](https://en.wikipedia.org/wiki/Pyramid_(image_processing)) (scale space): one step consists of *blur then downsample*

### Algorithm Steps

1. Get all bounding boxes/patches from image at scale level t
2. Run the FCN on all the patches
3. (Apply NMS to only consider the valid ones) -> what about moving it after having done all scale levels? Maybe it's anyway a step to perform
4. Change scale level t-1 (i.e. downscale = blur -> downsampling), then go to  step 1 unless we are done exploring the scale levels
5. Make detection across different scale levels

## Theoretical Part

### (a) Fully convolutional neural networks vs. neural networks with fully connected layers.

> Explain the purpose of fully connected layers in convolutional neural networks. In which scenarios would you apply a fully convolutional neural network instead of a neural network with a fully connected layer?

### (b) Converting a fully connected to a fully convolutional layer.

> Explain how to convert a fully connected layer to a fully convolutional layer such that the fully convolutional layer provides the same functionality.

Maybe: "Hence the final dense layers can be replaced by a convolution layer achieving the same result. But now the advantage of doing this is the size of input need not be fixed anymore. When involving dense layers the size of input is constrained and hence when a different sized input has to be provided it has to be resized. But by replacing a dense layer with convolution, this constraint doesn't exist."

### (c) Negative training examples.

> The MNIST training data only contains positive training examples, i.e. image patches holding an actual digit. Imagine that we want to reduce the number of false positives and duplicate detections, by introducing negative training examples. What would you change in your FCN model and / or loss function? How could you construct negative training examples based on the data we have already?

* Change in FC: maybe adding an extra dimension in the output feature map (from 1x1x10 to 1x1x11) expressing the "confidence of an object being present in the box/image"
* Change in loss: ?
* Build negative examples: back images? Localized noise/random white pixels (+blurring)? VAE?

From "Pedestrian detection with unsupervised multi-stage feature learning":
"Bootstrapping
Bootstrapping is typically used in detection settings by
multiple phases of extracting the most offending negative
answers and adding these samples to the existing dataset
while training. For this purpose, we extract 3000 nega-
tive samples per bootstrapping pass and limit the number
of most offending answers to 5 for each image. We perform
3 bootstrapping passes in addition to the original training
phase (i.e. 4 training passes in total)."

## Advanced Part

* Evaluate your network from the mandatory part on rotated versions of the evaluation images provided on Canvas and merge the corresponding detections. Similar to position and scale, avoid false duplicate detections caused by the multiple rotations considered.
* Use data augmentation to train a variant of your fully convolutional neural network that can be applied on rotated digits.


## Report Structure

### Introduction

### Method

### Experimental Evaluation

### Theoretical Part

### Advanced Part

### Conclusions