function [numA,numB] = count_lego(I)
% Using methods to detect the number of target lego bricks
% References:
% Segment by hsv image
% https://en.wikipedia.org/wiki/HSL_and_HSV
% Rigionprops, bwlable,SIFT, BagOfFeature...
% https://cn.mathworks.com/help/
% Lego Counting example: https://github.com/Approximetal/count-lego
%% counting LEGO Green Brick A
I = im2double(I);
% Ig = rgb2gray(I);
L=colorGreen(I); % select green bricks
%  select bricks by bounder shape
m1 = zeros(size(L));
[L3,num3,aa3,~,~,da3,ec3,~] = seg_area(L);
for j = 1:num3
    idx = find(L3==j);
    if ec3(j)>0.81&&ec3(j)<0.95&&da3(j)<0.21&&aa3(j)>3000
        m1(idx)=1;
    end
end
%figure(8),imshow(m3)
m_a = m1;
[~,numA] = bwlabel(m1,8);
disp(numA)
% 
%% Counting Yellow B
%
LL=colorYellow(I);% select Yellow Bricks
m4 = zeros(size(LL));m3 = m4;
m4(1,:)=1; m4(end,:)=1;m4(:,1)=1;m4(:,end)=1;
% figure(1),subplot(221),imagesc(LL)
[L3,num3,aa3,~,~,da3,ec3,~] = seg_area(LL);
for j = 1:num3
    idx = find(L3==j);
    m5 = zeros(size(LL));
    m5(idx) = 1;
    m2 = m4&m5;
    idy = find(m2>0);
    if length(idy)>50||aa3(j)<8000
        continue
    end
    if (ec3(j)<0.8&&da3(j)<0.2&&aa3(j)>10000&&aa3(j)<35000)||(ec3(j)<0.9&&da3(j)<0.25&&aa3(j)<15000)||(ec3(j)<0.5&&da3(j)<0.02)
        m3(idx)=1;
    end
end
%figure(8),imshow(m3)
m_b = m3;
[~,numB] = bwlabel(m3,8);
disp(numB)
m_AB = m_b-m_a;
figure,imagesc(m_AB)
end
