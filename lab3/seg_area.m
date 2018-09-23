function [L,num,aa,ca,ma,da,ec,stats] = seg_area(Ia)
[L,num] = bwlabel(Ia,8);% separate image into connected regions
stats = regionprops(L,'Area','ConvexArea','Eccentricity');
aa = cat(1,stats.Area);% pixel size in each region
ca = cat(1,stats.ConvexArea);% filled region into convex area
ma = ca-aa;%  filled pixels
da = ma./aa;
ec = cat(1,stats.Eccentricity);%elliptic eccentricity
end