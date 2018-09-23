function [L,num]=colorGreen(I)
    %% Transfer RGB to HSV
hsv=rgb2hsv(I);
h=hsv(:,:,1);
s=hsv(:,:,2);
I = im2double(I);
Ig = rgb2gray(I);
Ig = medfilt2(Ig,[3 3]);
%% Lego_Green Morphological operations
I1 = h>0.35&h<0.55;
I1 = I1.*(s>0.5&s<0.95);
se = strel('disk',4);
I2=imdilate(I1,se);
I2=imerode(I2,se);
I2 = imfill(I2,'holes');
a3 = imerode(I2,strel('disk',10));
a3 = imopen(a3,strel('disk',10));
I2 = bwareaopen(a3,1000);
I2 = imerode(I2,strel('disk',8));
% figure(1),subplot(2,2,1);imshow(I2)

%% Segementation 
% detect single lego or overlapping lego
[L,num,aa,~,ma,~,~,~] = seg_area(I2);
L1 = zeros(size(L));
m1 = L1; m2 = m1; m3 = m2;
% Pick up the areas which have multipe bricks
 for i = 1:num
     if ma(i)>7000&&aa(i)>36000 % detect large area 
                                % && not convex area(two bricks)
         idx = find(L == i);
         L(idx) = 0;
         L1(idx) = 1; % means have overlapping 
     end
 end
 %  preprocessing overlapping lego bricks
 me = L1.*Ig;
 idx0 = find(L1==0);
 ne = edge(me,'sobel','nothinning');
 ne = imclose(ne,strel('disk',2));
 n2 = L1 - ne; %backgroound
 n2(find(n2==-1))=0;
 n2 = imerode(n2,strel('disk',4));
%  subplot(2,2,2);imshow(n2)
 [L1,num1,~,~,ma1,da1,ec1,~] = seg_area(n2);
 for j = 1:num1
     idx = find(L1==j);
     if da1(j)>5 
     L1(idx) = 0;
     n2(idx) = 0;
     end
     if ma1(j)<100&&ec1(j)<0.88
         m1(idx) = 1;
     end
 end
 n3 = imdilate(m1,strel('disk',28));
 n3 = n3|n2;
 n3 = imfill(n3,'holes');
 n3(idx0)=0;
 n3 = bwareaopen(n3,300);
 
% Segement bricks by using Watershed
 [L2,num2,~,~,ma2,~,~,~] = seg_area(n3);
for k = 0.4:0.1:0.9
    for i = 1:num2
        idx = find(L2==i);
        if ma2(i)>5000
            m2(idx)=1;
            L2(idx) = 0;
        else
            L2(idx) = 1;
        end
    end
    if max(max(m2))>0
    sw = seg_watershed(m2,k);
    L2 = L2|sw;
    [L2,num2,~,~,ma2,~,~,~] = seg_area(L2);
    else
        break
    end
end
L = L|L2;
L = imerode(L,strel('disk',5));
subplot(2,2,3);imshow(L)
L = bwareaopen(L,1000);
% figure(1),imagesc(L);
    
end