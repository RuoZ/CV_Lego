%% Feature Based 
% Reference: 
% GitHub DeepLearning ToolBox: https://github.com/rasmusbergpalm/DeepLearnToolbox
%Matlab Document
%https://uk.mathworks.com/help/vision/local-feature-extraction.html
O1=imread('/Users/user/Documents/MATLAB/lab3/yellow_2by2brick.jpg');
O2=imread('/Users/user/Documents/MATLAB/lab3/green_2by4brick.jpg');
O3=imread('test.jpg');
T1=imread('/Users/user/Documents/MATLAB/lab3/training_images/train01.jpg');
T2=imread('/Users/user/Documents/MATLAB/lab3/training_images/train02.jpg');
T3=imread('/Users/user/Documents/MATLAB/lab3/training_images/train03.jpg');
T4=imread('/Users/user/Documents/MATLAB/lab3/training_images/train04.jpg');
T5=imread('/Users/user/Documents/MATLAB/lab3/training_images/train05.jpg');
T6=imread('/Users/user/Documents/MATLAB/lab3/training_images/train06.jpg');
T7=imread('/Users/user/Documents/MATLAB/lab3/training_images/train07.jpg');
T8=imread('/Users/user/Documents/MATLAB/lab3/training_images/train08.jpg');
T9=imread('/Users/user/Documents/MATLAB/lab3/training_images/train09.jpg');
T10=imread('/Users/user/Documents/MATLAB/lab3/training_images/train10.jpg');
T11=imread('/Users/user/Documents/MATLAB/lab3/training_images/train11.jpg');
T12=imread('/Users/user/Documents/MATLAB/lab3/training_images/train12.jpg');
% cd=count_lego(T1);
% cd=count_lego(T2);

T3=T1;% test image
O2=rgb2gray(O2);% green brick
T3=rgb2gray(T3);
%% detect features
%Detect corners using Harris?Stephens algorithm 
points1 = detectHarrisFeatures(O2);
points2 = detectHarrisFeatures(T3);
%Detect corners using FAST algorithm ---no enough points
points3 = detectFASTFeatures(O2)
points4 = detectFASTFeatures(T3)
% Detect SURF features and return SURFPoints object
points1 = detectSURFFeatures(O2)
points2 = detectSURFFeatures(T3)


figure;subplot(121),imshow(T3)
hold on;plot(selectStrongest(points2, 100));
subplot(122),imshow(O2),hold on;
plot(selectStrongest(points1, 50));
%%
[features1,points1] = extractFeatures(O2,points1);
[features2,points2] = extractFeatures(T3,points2);

indexPairs = matchFeatures(features1,features2);

matchedPoints1 = points1(indexPairs(:,1),:);
matchedPoints2 = points2(indexPairs(:,2),:);
figure; subplot(211),showMatchedFeatures(O2,T3,matchedPoints1,matchedPoints2,'montage');
title('Matched Points (Inliers Only)');
[tform, inlierBoxPoints, inlierScenePoints] = ...
    estimateGeometricTransform(matchedPoints1, matchedPoints2, 'affine');
subplot(212),
showMatchedFeatures(O1, T3, inlierBoxPoints, ...
    inlierScenePoints, 'montage');
title('Matched Points (Inliers Only)');

