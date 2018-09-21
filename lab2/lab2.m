Ia=imread('rooster.jpg');
IaRbg=im2double(Ia);
Ia=rgb2gray(IaRbg);
Ib=imread('woods.png');
Ib=im2double(Ib);
Ic=imread('elephant.png');
Ic=im2double(Ic);
%
figure(11),subplot(1,2,1),imagesc(Ia);
subplot(1,2,2),imagesc(Ib);
colormap('gray')
%% Question 2 Redundancy in Natural Images

corr2(Ia,Ia);
shiftsize=30;
x=0:1:shiftsize;
y1=corrShift(Ia,shiftsize);
y2=corrShift(Ib,shiftsize);
figure(1),plot(x,y1,x,y2),xlabel('shift distance'),ylabel('correlation coefficient');

% function [y]=corrShift(Image,shiftsize)
% y=zeros(shiftsize+1);
% for shiftPosition=0:1:shiftsize
%     shift=zeros(2*shiftsize+1);
%     shift(shiftsize+1,shiftsize+1-shiftPosition)=1;
%     ImageShift=conv2(Image,shift,'same');
%     y(shiftPosition+1)=corr2(Image,ImageShift);
% end
% end
% ? shift matrix convlution with image  use [1,61]or [61,61]????

%% Question 3.1 Redundancy Reduction using DoG masks

g1=fspecial('gaussian',[40,40],6);
g2=fspecial('gaussian',[40,40],2);
DoG=g2-g1;
IaDoG=conv2(Ia,DoG,'same');
y3=corrShift(IaDoG,shiftsize);
IbDoG=conv2(Ib,DoG,'same');
y4=corrShift(IbDoG,shiftsize);
figure(2),subplot(2,1,1),plot(x,y3,x,y4);


g3=fspecial('gaussian',[30,30],4);
g4=fspecial('gaussian',[30,30],0.5);
DoG2=g4-g3;
IaDoG2=conv2(Ia,DoG2,'same');
y5=corrShift(IaDoG2,shiftsize);
IbDoG2=conv2(Ib,DoG2,'same');
y6=corrShift(IbDoG2,shiftsize);
subplot(2,1,2),plot(x,y5,x,y6);
figure(23),subplot(2,2,1),imagesc(IaDoG);title('Dog: sigma 2-sigma 6 '),colorbar
subplot(2,2,2),imagesc(IbDoG);title('Dog: sigma 2-sigma 6 '),colorbar
subplot(2,2,3),imagesc(IaDoG2);title('Dog: sigma 0.5-sigma 4 '),colorbar
subplot(2,2,4),imagesc(IbDoG2);title('Dog: sigma 0.5-sigma 4 '),colorbar
colormap('gray')

%}

x=linspace(-19,19);
y=normpdf(x,0,3);
figure(320)
plot(x,y,'g');
hold on
x2=linspace(-19,19);
y2=normpdf(x,0,2);
plot(x2,y2,'r');
hold on
% x3=linspace(-19,19);
% y3=normpdf(x,0,2);
% plot(x3,y3,'r');

%% Question 3.2 Color Opponent Cells
g6=fspecial('gaussian',[19,19],3);% surround
g5=fspecial('gaussian',[19,19],2);% center

RImC=conv2(IaRbg(:,:,1),g5,'same'); % red center
RImS=conv2(IaRbg(:,:,1),g6,'same'); % red suround
GImC=conv2(IaRbg(:,:,2),g5,'same');% green center
GImS=conv2(IaRbg(:,:,2),g6,'same');% green surround
RonGoff=RImC-GImS;
GonRoff=GImC-RImS;
figure(4),subplot(2,2,1),imagesc(RonGoff);title('red on,green off');colorbar
subplot(2,2,2),imagesc(GonRoff);title('green on,red off');colorbar

BImC=conv2(IaRbg(:,:,3),g5,'same'); % blue center
BImS=conv2(IaRbg(:,:,3),g6,'same'); % blue suround
YIm=mean(IaRbg(:,:,1:2),3);
YImC=conv2(YIm,g5,'same');% yellow center
YImS=conv2(YIm,g6,'same');% yello surround
BonYoff=BImC-YImS;
YonBoff=YImC-BImS;
subplot(2,2,3),imagesc(BonYoff);title('blue on,yellow off');colorbar
subplot(2,2,4),imagesc(YonBoff);title('yellow on,blue off');colorbar
colormap('jet')
%% Question 3.2.2
g5=fspecial('gaussian',[19,19],2);
RonGoff2=RImC-GImC;
GonRoff2=GImC-RImC;
figure(5),subplot(2,2,1),imagesc(RonGoff2);title('red on,green off');colorbar
subplot(2,2,2),imagesc(GonRoff2);title('green on,red off');colorbar

BonYoff2=BImC-YImC;
YonBoff2=YImC-BImC;
subplot(2,2,3),imagesc(BonYoff2);title('blue on,yellow off');colorbar
subplot(2,2,4),imagesc(YonBoff2);title('yellow on,blue off');colorbar
colormap('jet')

figure(32), subplot(2,2,1), mesh(g5-g6),
subplot(2,2,2), imagesc(g5-g6),
subplot(2,2,3), imagesc(g6-g5),


g7=fspecial('gaussian',[19,19],3);% surround
g8=fspecial('gaussian',[19,19],1);% center

RImC3=conv2(IaRbg(:,:,1),g8,'same'); % red center
GImS3=conv2(IaRbg(:,:,2),g5,'same');% green surround
RonGoff3=RImC3-GImS3;

RImC4=conv2(IaRbg(:,:,1),g7,'same'); % red center
GImS4=conv2(IaRbg(:,:,2),g7,'same');% green surround
RonGoff4=RImC4-GImS4;

RImC5=conv2(IaRbg(:,:,1),g5,'same'); % red center sigma2
GImS5=conv2(IaRbg(:,:,2),g8,'same');% green surround sigma1
RImC6=conv2(IaRbg(:,:,1),g8,'same');% red center sigma1
% picture 5,3 Çø±ð£¿
RonGoff5=RImC5-GImS5;
RonGoff6=RImC6-GImS5;

figure(322),subplot(2,2,1),imagesc(RonGoff);title('P1:red on(2),green off(3)');colorbar
subplot(2,2,2),imagesc(RonGoff2);title('P2:red on(2),green off(2)');colorbar
subplot(2,2,3),imagesc(RonGoff3);title('P3:red on(1),green off(2)');colorbar
subplot(2,2,4),imagesc(RonGoff4);title('P4:red on(3),green off(3)');colorbar

colormap('jet')


%% Question 4.1 V1 Orientation Selective Cells Modelled Using Gabor Masks
gabor1=gabor(4,8,90,0.5,0);
%imagesc(gabor1);
IcGabor=conv2(Ic,gabor1,'valid');
figure(6),subplot(1,3,1),imagesc(IcGabor);colorbar

gabor2=gabor(4,8,90,0.5,90);
IcGabor2=conv2(Ic,gabor2,'valid');

IcCombine=sqrt(IcGabor.^2+IcGabor2.^2);
subplot(1,3,2),imagesc(IcCombine);colorbar

%subplot(1,3,3),imagesc(gabor1)

%figure(7),imagesc(sqrt(gabor1.^2+gabor2.^2))

%% Question 4.2 Complex Cells (at one orientation)&&(at multiple orientations)
gaborR1=gabor(4,8,0,0.5,0);
%imagesc(gaborR1);
gaborR2=gabor(4,8,15,0.5,0);
gaborR3=gabor(4,8,30,0.5,0);
gaborR4=gabor(4,8,45,0.5,0);
gaborR5=gabor(4,8,60,0.5,0);
gaborR6=gabor(4,8,75,0.5,0);
gaborR7=gabor(4,8,90,0.5,0);
gaborR8=gabor(4,8,105,0.5,0);
gaborR9=gabor(4,8,120,0.5,0);
gaborR10=gabor(4,8,135,0.5,0);
gaborR11=gabor(4,8,150,0.5,0);
gaborR12=gabor(4,8,165,0.5,0);

IcGaborR1=conv2(Ic,gaborR1,'valid');
IcGaborR2=conv2(Ic,gaborR2,'valid');
IcGaborR3=conv2(Ic,gaborR3,'valid');
IcGaborR4=conv2(Ic,gaborR4,'valid');
IcGaborR5=conv2(Ic,gaborR5,'valid');
IcG(:,:,6)=conv2(Ic,gaborR6,'valid');
IcG(:,:,7)=conv2(Ic,gaborR7,'valid');
IcG(:,:,8)=conv2(Ic,gaborR8,'valid');
IcG(:,:,9)=conv2(Ic,gaborR9,'valid');
IcG(:,:,10)=conv2(Ic,gaborR10,'valid');
IcG(:,:,11)=conv2(Ic,gaborR11,'valid');
IcG(:,:,12)=conv2(Ic,gaborR12,'valid');
IcG(:,:,1)=IcGaborR1;
IcG(:,:,2)=IcGaborR2;
IcG(:,:,3)=IcGaborR3;
IcG(:,:,4)=IcGaborR4;
IcG(:,:,5)=IcGaborR5;
%IcG(:,:,6)=IcGaborR6;
IcMutiR=max(IcG,[],3);
%imagesc(IcGaborR1+IcGaborR2+IcGaborR3+IcGaborR4+IcGaborR5);colorbar
subplot(1,3,3),imagesc(IcMutiR);colorbar
%}