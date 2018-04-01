README

***TRAINING***
The main.m file contains the code to train the KNN model for four feature extraction methods, namely HOCD, HOCD+Gabor, Gabor and SURF using Bag of Words

Only one of the feature extraction techniques can be run at a time.

The main.m file also provides a template in the end to test the trained model on 10 actual images of hands that are captured by us. These images are present in ‘test_images.mat’ and are called by the template before it is run. 

The error metric that is displayed at the end, gives the test error of the classifier that is used.

***PREDICTING***
All of the code except for what is in the 3 folders should be placed on the server directory. The code in the "ClientCode" folder should be used to create an Android app in Android studio. Make sure to change line 51 in SIFTExampleActivity.java to "<address of the server directory>/predictASLLoop.php". Prior to running the Android code, make sure to run predictASLLoop.m on the server. 
When using the Android app, turn the phone 90 degrees counter-clockwise and use the volume up button to take a photo. The code will automatically run and return a predicted letter image.
