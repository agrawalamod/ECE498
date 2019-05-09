Collaboration: Amod Agrawal (amodka2) & Maraim Vardishvili (mariamv2)

Stage 1: Android Code is present in /SensorApp.
Our code also stores derived sensor values but we don't use them anywhere in our algorithms. Only 2 axes (Y axis and Z axis) of accelerometer data is used.

Stage 2: Data files for 5 activities.

Stage 3: Step Detection, run file stepDetection.m. Dependency: makeContinuous.m in the same directory. 
A local data file is present to run the code. The algorithm uses a low pass filter to smoothen the sudden changes in data and reduce higher frequency components. Based on certain parameters and step size, it does peak detection to find number of steps. We tried running it on multiple data files and it was able to detect correct number of steps with an error of +- 1 to 2 steps.

Stage 4: The features we use are me Mean, Max and Variance. The feature plots show how the features vary for different activities. The sensor traces show the data afer running low pass filter. 

Based on the feature plots, we choose mean, max and variance are our three best features. The 3D cluster plot clearly shows that jumping and running have similar features which are very spread out and do not form compressed clusters. However, jumping has higher values than running and therefore, can be seperated out. It's hard to linearly separate running and stairs using just these features. Similarly, stairs and walking have similar accelerometer patterns. They form nice clusters but merge into each other. Walking can very well be seen forming a separate cluster. More complex features using frequency can be utilized to seperate the activities.

Run cluster.m to view results. Dependencies: makeContinous.m and findFeatures.m in the same directory.
