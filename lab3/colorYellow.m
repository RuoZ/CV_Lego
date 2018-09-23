function L=colorYellow(I)
hsv=rgb2hsv(I);
h=hsv(:,:,1);
s=hsv(:,:,2);
I = im2double(I);
Ig = rgb2gray(I);
Ig = medfilt2(Ig,[3 3]);
b1 = h>0.07&h<0.165;
b1 = b1.*(s>0.55);
se = strel('disk',4);
b2=imdilate(b1,se);
b2=imerode(b2,se);
b3 = imfill(b2,'holes');
% b3 = imopen(b3,se);
b2=imerode(b2,se);
% figure(2),subplot(221),imagesc(b3)
b3 = bwareaopen(b2,10000);

%% Segementation
[L,num,aa,~,ma,da,~,~] = seg_area(b3);
% Pick up the areas which have multipe bricks
m = zeros(size(b3));
m1=m;m2=m1;
 for i = 1:num
     if (da(i)*ma(i)>4000||da(i)>0.14&&aa(i)>40000)
         idx = find(L == i);
         L(idx) = 0;
         m(idx) = 1;
     end
 end
if max(max(m))>0
     [L2,num2,~,~,ma2,~,~,~] = seg_area(m);

 m = seg_watershed(m,0.7);
 m = imerode(m,strel('disk',10));
 L = L|m;
 L = L|L2;
[L,num,~,~,ma,da,~,~] = seg_area(L);
end
% subplot(222),imagesc(L)
m = zeros(size(b3));
 for i = 1:num
     if (da(i)>0.14&&ma(i)>8000)
         idx = find(L == i);
         L(idx) = 0;
         m(idx) = 1;
     end
 end
L = imerode(L,strel('disk',5));

% subplot(223),imagesc(L)

 % process edges
 if max(max(L))>0
 % Prior processing
 me = L.*Ig;
 ne = edge(me,'sobel','nothinning');
 ne = imclose(ne,strel('disk',2));
 n2 = L - ne;
 idx = find(n2==-1);
 n2(idx)=0;
 n2 = imerode(n2,strel('disk',4));
 [L1,num1,aa1,~,~,da1,~,~] = seg_area(n2);
%  subplot(222),imagesc(L1)
 for j = 1:num1
     idx = find(L1==j);
     if da1(j)>5
     L1(idx) = 0;
     n2(idx) = 0;
     end
     if aa1(j)<3000
         m1(idx) = 1;
     end
 end
 n3 = imdilate(m1,strel('disk',28));
 n3 = n3|n2;
 n3 = imfill(n3,'holes');
%  subplot(223),imagesc(n3)
 idx0 = find(m==0);
 n3(idx0)=0;    
 n3 = bwareaopen(n3,500);
 sw = seg_watershed(n3,0.7);
L = sw|L;
% subplot(224),imshow(L)

 end
end