%% Low-level Computer Vision

Ia=imread('rooster.jpg');
Ib=imread('boxes.pgm');
Ibd=im2double(Ib);
Iad=im2double(Ia);
Iadg=rgb2gray(Iad);

%%  Question 3.1 filters/ Box masks
% convolute image with masks--> smoothing image
%h=ones(3,3)/9; 
% different size average masks
H=fspecial('average',[5,5]);
H2=fspecial('average',[25,25]);

% compare original figures and conv2 figures
% image 1
figure(1),
%subplot(2,2,1),imagesc(Ia); oringin image
Pa5=conv2(Iadg,H,'same');
subplot(2,2,1),imagesc(Pa5);colorbar % smoothing image
Pa25=conv2(Iadg,H2,'same');title('P1: conv with mask 5*5');colorbar
subplot(2,2,2),imagesc(Pa25);title('P2: conv with mask 25*25');colorbar

% image 2
%figure(2),subplot(2,2,1),imagesc(Ib); 
Pb5=conv2(Ibd,H,'same');
subplot(2,2,3),imagesc(Pb5);title('P3: conv with matrix 5*5');colorbar
Pb25=conv2(Ibd,H2,'same');
subplot(2,2,4),imagesc(Pb25);title('P4: conv with matrix 25*25');colorbar
colormap('gray');

%% Question 3.2.1 Gaussian mask with different sigma

H6=fspecial('gaussian',[60,60],10);
H5=fspecial('gaussian',[10,10],1.5);
% H51=fspecial('gaussian',[60,60],1.5);
% figure(31),subplot(2,2,1),mesh(H5); % show Gaussian masks
% subplot(2,2,2),mesh(H6); 
% subplot(2,2,3),mesh(H51);

% convolute image with Gaussian masks--> smoothing image
figure(2),
%subplot(2,2,1),imagesc(Ia);
PaGau15=conv2(Iadg,H5,'same');
subplot(2,2,1),imagesc(PaGau15);
title('P1:with Gaussian matrix 10*10(sigma:1.5)');colorbar
PaGau10=conv2(Iadg,H6,'same');
subplot(2,2,2),imagesc(PaGau10);
title('P2:with Gaussian matrix 60*60(sigma:10)');colorbar

%figure(2),subplot(2,2,1),imagesc(Ib);
PbGau15=conv2(Ibd,H5,'same');
subplot(2,2,3),imagesc(PbGau15);
title('P3:with Gaussian matrix 10*10(sigma:1.5)');colorbar
PbGaus10=conv2(Ibd,H6,'same');
subplot(2,2,4),imagesc(PbGaus10);
title('P4:with Gaussian matrix 60*60(sigma:10)');colorbar
colormap('gray');

%% Question 3.2.2 Compare time consuming of different convolution process 
figure(3);
H3=fspecial('gaussian',[1,60],10);
% convolve twice with 1D Gaussian masks
tic;
PaGaus=conv2(Iadg,H3,'same');
PaGaus2=conv2(PaGaus,H3','same');
subplot(2,1,1),imagesc(PaGaus2);colorbar
toc
% convolve with 2D Gaussian mask
tic;
H4=conv2(H3,H3','full');
PaGaus3=conv2(Iadg,H4,'same');
subplot(2,1,2),imagesc(PaGaus3);colorbar
toc
% two picture are the same, and time 1> time 2
checkP=PaGaus2-PaGaus2;
figure(32),imagesc(checkP);title('Check whether the two images are the same ');colorbar

%% Question 4.1  Difference Masks 1D
figure(41); 
y=sin([0:0.01:2*pi]); subplot(3,1,1),plot(y); %#ok<NBRAK>
yd1=conv2(y,[-1,1],'valid');subplot(3,1,2),plot(yd1)
%ydd=diff(y);subplot(3,1,3),plot(ydd)
%ydd2=diff(yd1);subplot(3,1,2),plot(ydd2)
yd2=conv2(y,[-1,2,-1],'valid');subplot(3,1,3),plot(yd2)
% convolution calulating 

%% Question 4.2 Difference Masks 2D
% two Laplacian masks with different amplitudes
H7=[-1,-1,-1;-1,8,-1;-1,-1,-1];
H8=H7/8;
figure(5),
%subplot(2,2,1),imagesc(Ia);PbLoG
% PaLa=conv2(Iadg,H7,'same');
% subplot(2,2,1),imagesc(PaLa);colorbar
% PaLa2=conv2(Iadg,H8,'same');
% subplot(2,2,2),imagesc(PaLa2);colorbar
% colormap('gray');
% H9=fspecial('gaussian',[5,5],5);
PbLa=conv2(Ibd,H7,'same');
subplot(1,2,1),imagesc(PbLa);colorbar
PbLa2=conv2(Ibd,H8,'same');
subplot(1,2,2),imagesc(PbLa2);colorbar
% all pixels between the picture PaLa and PaLa2 : 8 times

%% Question 4.3 Other Difference masks
% many difference masks for approximating the intensity-level gradient of an image
% Sobel mask
maskSobel=fspecial('sobel');
maskSobel2=maskSobel';
figure(6),
PbSobel=conv2(Ibd,maskSobel,'same');
subplot(2,2,1),imagesc(PbSobel);title('sovbel mask');colorbar
PbSobel2=conv2(Ibd,maskSobel2,'same');
subplot(2,2,2),imagesc(PbSobel2);title('sovbel mask ^T');colorbar
colormap('jet');
% Prewitt mask
maskPrewitt = fspecial('prewitt');
maskPrewitt2=maskPrewitt';
PbPrewitt=conv2(Ibd,maskPrewitt,'same');
subplot(2,2,3),imagesc(PbPrewitt);title('Prewitt mask');colorbar
PbPrewitt2=conv2(Ibd,maskPrewitt2,'same');
subplot(2,2,4),imagesc(PbPrewitt2);title('Prewitt mask^T');colorbar
% laLoG=conv2(Iadg,maskLoG,'same');
% subplot(2,1,1),imagesc(laLoG);colorbar
colormap('jet');

%% Question 5  Edge Detection
% Question 5.1.1 Gaussian derivative masks
H9=fspecial('gaussian',[45,45],5);
hh=[-1,1];
maskGussDerivX=conv2(H9,hh,'same');
maskGussDerivY=conv2(H9,hh','same');
figure(7), % show gaussian masks
subplot(2,2,1),mesh(maskGussDerivX);title('P1:Gaussian derivative masks X');colorbar
subplot(2,2,2),mesh(maskGussDerivY);title('P2:Gaussian derivative masks Y');colorbar
% show the edge detection method using Gaussian masks 
PbGussDerX=conv2(Ibd,maskGussDerivX,'same');
subplot(2,2,3),imagesc(PbGussDerX);title('P3:convolve with Gaussian derivative X');colorbar
PbGussDerY=conv2(Ibd,maskGussDerivY,'same');
subplot(2,2,4),imagesc(PbGussDerY);title('P4:convolve with Gaussian derivative Y');colorbar
colormap('jet');

%% Question 5.1.2

% standard deviation 1.5
% compare  horizontal and vertical Gaussian derivative mask  
H10=fspecial('gaussian',[10,10],1.5);
maskGussDerivX2=conv2(H10,hh,'same');
maskGussDerivY2=conv2(H10,hh','same');
figure(8),
subplot(2,2,1),mesh(maskGussDerivX2);title('P1:Gaussian derivative X(1.5)');colorbar
subplot(2,2,2),mesh(maskGussDerivY2);title('P2:Gaussian derivative Y(1.5)');colorbar

PbGussDerX2=conv2(Ibd,maskGussDerivX2,'same');
subplot(2,2,3),imagesc(PbGussDerX2);title('P3:convolve with Gaussian derivative X');colorbar

PbGussDerY2=conv2(Ibd,maskGussDerivY2,'same');
subplot(2,2,4),imagesc(PbGussDerY2);title('P4:convolve with Gaussian derivative X');colorbar
colormap('jet');

%% Question 5.1.3 edge detection results
%L2 normalization
% lbdg=sqrt(maskGussDerivX2.^2+maskGussDerivY2.^2);

l2box=sqrt(PbGussDerX2.^2+PbGussDerY2.^2);

PaGussDerX2=conv2(Iadg,maskGussDerivX2,'same');
PaGussDerY2=conv2(Iadg,maskGussDerivY2,'same');
l2rooster=sqrt(PaGussDerX2.^2+PaGussDerY2.^2);
% %subplot(2,2,1),mesh(lbdg);
% PbL2nor=conv2(Ibd,lbdg,'same');
% PbL2nor2=conv2(Iadg,lbdg,'same');
figure(9),
subplot(1,2,1),imagesc(l2box);colorbar
subplot(1,2,2),imagesc(l2rooster);colorbar
% subplot(2,2,2),imagesc(l2box-PbL2nor);colorbar
colormap('gray');

% % 微分后的两个卷积 的normalization 
% figure(91),
% subplot(1,2,1),imagesc(PbL2nor);colorbar
% subplot(1,2,2),imagesc(PbL2nor2);colorbar
% colormap('gray');

%% Question 5.2 Laplacian of Gaussian (LoG) mask

H7=[-1,-1,-1;-1,8,-1;-1,-1,-1];
H8=H7/8;
H9=fspecial('gaussian',[45,45],5);
H10=fspecial('gaussian',[10,10],1.5);
maskLoG=conv2(H10,H8,'valid');% H10 sigma=1.5
figure(10),subplot(2,2,1),mesh(maskLoG);title('P1: LoG mask(sigma=1.5)');colorbar

PbLoG=conv2(Ibd,maskLoG,'same');
subplot(2,2,3),imagesc(PbLoG);title('P3: LoG(sigma=1.5)');colorbar
colormap('jet');
% standard deviation 5
maskLoG2=conv2(H9,H8,'valid');% H9 guss with sigma=5, size [45,45]
subplot(2,2,2),mesh(maskLoG2);title('P2: LoG mask(sigma=5)');colorbar

PbLoG2=conv2(Ibd,maskLoG2,'same');
subplot(2,2,4),
%imagesc(Ibd);title('P4: original image');colorbar
imagesc(PbLoG2);title('P4: LoG(sigma=5)');colorbar
colormap('jet');
% Compare different sigma LoG masks
% rooster image
figure(11),
laLoG=conv2(Iadg,maskLoG,'same');
subplot(1,2,1),imagesc(laLoG);title('P1: LoG(sigma=1.5)');colorbar
laLoG2=conv2(Iadg,maskLoG2,'same');
subplot(1,2,2),imagesc(laLoG2);title('P2: LoG(sigma=5)');colorbar
colormap('jet');

%% Question 5.3 Difference of Gaussians (DoG) mask
H7=[-1,-1,-1;-1,8,-1;-1,-1,-1];
H8=H7/8;
H9=fspecial('gaussian',[45,45],5);

hg6=fspecial('gaussian',[45,45],6);
hg3=fspecial('gaussian',[45,45],3);
hgd=hg3-hg6;
% show DoG mask
figure(12),subplot(2,2,1),mesh(hgd)
maskLoG3=conv2(H9,H8,'same');% H9 guss with sigma=5, size [45,45]
subplot(2,2,2),mesh(maskLoG3);colorbar
% Compare LoG and DoG masks
minloss=100000;
maskLoG3=maskLoG3./max(max(maskLoG3));% maskLoG3 is the LoG mask created in the previous section 
loss1=sqrt(sum(sum(hgd-maskLoG3).^2));

finalL=-1;
for sigma1=3.1:0.1:6 %sigma1 from 3.1 to 10;
    for sigma2=3:0.1:sigma1-0.1 %sigma2 from 3 to sigma1(assume that sigma2<sigma1)
        hgl=fspecial('gaussian',[45,45],sigma1); 
        hgs=fspecial('gaussian',[45,45],sigma2);   
        hdgg=hgs-hgl; % hdgg is DoG mask generating by subtracting one Gaussian from another Gaussian.        
        hdgg=hdgg./max(max(hdgg)); 
        loss=sqrt(sum(sum(hdgg-maskLoG3).^2));
        if loss<=minloss
            minloss=loss;
            final1=sigma1;
            final2=sigma2;
            best=hdgg;
        end
    end
end
disp(final1)
disp(final2)
disp(minloss)

subplot(2,2,3),mesh(best);colorbar



%% Question 6.1 Gaussian Image Pyramid 

g=fspecial('gaussian',[10,10],1);
%g=fspecial('gaussian',[45,45],5);
I2 =imresize(conv2(Iadg,g,'same'),0.5,'nearest');
I3 =imresize(conv2(I2,g,'same'),0.5,'nearest');
I4 =imresize(conv2(I3,g,'same'),0.5,'nearest');
I5 =imresize(conv2(I4,g,'same'),0.5,'nearest');

figure(13),subplot(2,2,1),imagesc(I2);title('1 level Gaussian pyramid '),colorbar
subplot(2,2,2),imagesc(I3);title('2 level Gaussian pyramid '),colorbar
subplot(2,2,3),imagesc(I4);title('3 level Gaussian pyramid '),colorbar
subplot(2,2,4),imagesc(I5);title('4 level Gaussian pyramid '),colorbar

%% Question 6.2 Laplacian Image Pyramid

L11=Iadg-imresize(I2,size(Iadg),'nearest');
L22=I2-imresize(I3,size(I2),'nearest');
L33=I3-imresize(I4,size(I3),'nearest');
L44=I4-imresize(I5,size(I4),'nearest');
figure(141),subplot(2,2,1),imagesc(L11);title('1 level Laplace pyramid '),colorbar
subplot(2,2,2),imagesc(L22);title('2 level Laplace pyramid '),colorbar
subplot(2,2,3),imagesc(L33);title('3 level Laplace pyramid '),colorbar
subplot(2,2,4),imagesc(L44);title('4 level Laplace pyramid '),colorbar
colormap('gray')
%% test L1= G0-[(s|up G1)*g], G1=s|down(G0*g2)
g1=fspecial('gaussian',[5,5],1);
Ll11=Iadg-conv2(imresize(I2,size(Iadg),'nearest'),g1,'same');
% padding 0 rather than the same value near the high level pyramid
% I20=zeros(size(Iadg));
% I20(1:2:341,1:2:386)=I2;
% Ll111=Iadg-4*conv2(I20,g1,'same');
Ll22=I2-conv2(imresize(I3,size(I2),'nearest'),g1,'same');
Ll33=I3-conv2(imresize(I4,size(I3),'nearest'),g1,'same');
Ll44=I4-conv2(imresize(I5,size(I4),'nearest'),g1,'same');
figure(1412),subplot(2,2,1),imagesc(Ll11);title('1-level Laplace pyramid '),colorbar
subplot(2,2,2),imagesc(Ll22);title('2-level Laplace pyramid '),colorbar
subplot(2,2,3),imagesc(Ll33);title('3-level Laplace pyramid '),colorbar
subplot(2,2,4),imagesc(Ll44);title('4-level Laplace pyramid '),colorbar
colormap('gray')

% reconstruct ?? Laplace 
L111=L11+conv2(imresize(I2,size(Iadg)),g,'same');
L222=L22+conv2(imresize(I3,size(I2)),g,'same');
L333=L33+conv2(imresize(I4,size(I3)),g,'same');
L444=L44+conv2(imresize(I5,size(I4)),g,'same');
figure(142),subplot(2,2,1),imagesc(L444);colorbar
subplot(2,2,2),imagesc(L333);colorbar
subplot(2,2,3),imagesc(L222);colorbar
subplot(2,2,4),imagesc(L111);colorbar
colormap('gray')
% DoG Pygramid (maybe wrong,not upsampling and then down sampling
L1=Iadg-conv2(Iadg,g,'same');
L2=I2-conv2(I2,g,'same');
L3=I3-conv2(I3,g,'same');
L4=I4-conv2(I4,g,'same');
L5=I5-conv2(I5,g,'same');
figure(14),subplot(2,2,1),imagesc(L1);colorbar
subplot(2,2,2),imagesc(L2);colorbar
subplot(2,2,3),imagesc(L3);colorbar
subplot(2,2,4),imagesc(L4);colorbar
%colormap('jet');

%% Question 7 Edge Detection 
Ic=imread('berkeley3096.jpg');
Icd=medfilt2(im2double(Ic));
Id=imread('berkeley189080.jpg');
Idd=medfilt2(im2double(Id));
Ie=imread('berkeley285079.jpg');
Ied=medfilt2(im2double(Ie));
%IcEdgeP1=edge(Icd,'prewitt',0.2);
%IcEdgeP2=~edge(Icd,'prewitt',0.1);
IcEdgeP3=~edge(Icd,'prewitt',0.08);
IcEdgeP4=~edge(Icd,'prewitt',0.0444);
IcEdgeC1=~edge(Icd,'canny',[0.157,0.195],0.65);
IcEdgeC2=~edge(Icd,'canny',[0.15,0.20],1.95);
[BW,thresh]=edge(Icd,'canny');
figure(15),subplot(2,2,1),imagesc(IcEdgeP3),title('P1: prewitt(0.08)');colorbar
subplot(2,2,2),imagesc(IcEdgeP4),title('P2: prewitt(0.0444)');colorbar
subplot(2,2,3),imagesc(IcEdgeC2),title('P3: canny,[0.15,0.20],1.95');colorbar
subplot(2,2,4),imagesc(IcEdgeC1),title('P4: canny,[0.157,0.195],0.65');colorbar
colormap('gray');

IdEdgeC2=~edge(Idd,'canny',[0.157,0.195],0.65);
IdEdgeC3=~edge(Idd,'canny',[0.155,0.162],1.3);
IdEdgeC4=~edge(Idd,'canny',[0.205,0.21],2.4);
IeEdgeC2=~edge(Ied,'canny',[0.157,0.195],0.65);
IeEdgeC3=~edge(Ied,'canny',[0.23,0.35],0.05);
IeEdgeC4=~edge(Ied,'canny',[0.3,0.51],0.07);

figure(16),subplot(2,2,1),imagesc(Idd),colorbar
subplot(2,2,2),imagesc(IdEdgeC2),colorbar
subplot(2,2,3),imagesc(IdEdgeC3),colorbar
subplot(2,2,4),imagesc(IdEdgeC4),colorbar
figure(17),subplot(2,2,1),imagesc(Ied),colorbar
subplot(2,2,2),imagesc(IeEdgeC2),colorbar
subplot(2,2,3),imagesc(IeEdgeC3),colorbar
subplot(2,2,4),imagesc(IeEdgeC4),colorbar
colormap('gray');

%{
%% test[original, gaussian, 1-derivative gaussian, 2 order dericative Gaussian(LoG)
aaaa=ones(64);
aaaa(:,33:64)=0;
figure(100);subplot(2,2,1),imagesc(aaaa),colorbar
H10=fspecial('gaussian',[30,30],3);
aaaa1=conv2(aaaa,H10,'same');%Gaussian mask
subplot(2,2,2),imagesc(aaaa1),colorbar
H101=conv2(H10,[-1,1],'valid');% 1 order Gaussian
aaaa2=conv2(aaaa,H101,'same');
subplot(2,2,3),imagesc(aaaa2),colorbar
H7=[-1,-1,-1;-1,8,-1;-1,-1,-1];
H8=H7/8;
H102=conv2(H10,H8,'valid');
aaaa4=conv2(aaaa,H102,'same');
subplot(2,2,4),imagesc(aaaa4),colorbar
%}