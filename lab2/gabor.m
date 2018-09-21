function gb=gabor(sigma,wavel,orient,aspect,phase)
%function gb=gabor(sigma,wavel,orient,aspect,phase)
%
% This function produces a numerical approximation to 2D Gabor function.
% Parameters:
% sigma  = standard deviation of Gaussian envelope, this in-turn controls the
%          size of the result (pixels)
% wavel  = the wavelength of the sin wave (pixels)
% orient = orientation of the Gabor from the vertical (degrees)
% aspect = aspect ratio of Gaussian envelope (0 = no modulation over "width" of
%          sin wave, 1 = circular symmetric envelope)
% phase  = the phase of the sin wave (degrees)

sz=fix(7*sigma./max(0.2,aspect));
if mod(sz,2)==0, sz=sz+1;end
 
[x y]=meshgrid(-fix(sz/2):fix(sz/2),fix(-sz/2):fix(sz/2));
 
% Rotation 
orient=orient*pi/180;
x_theta=x*cos(orient)+y*sin(orient);
y_theta=-x*sin(orient)+y*cos(orient);

phase=phase*pi/180;

gb=exp(-.5*((x_theta.^2/sigma^2)+(aspect^2*y_theta.^2/sigma^2))).*(cos(2*pi*(1./wavel)*x_theta+phase));
