function sw = seg_watershed(Is,threshold)
%ws = seg_watershed(Is,threshold)
%Using watershed to segment close bricks
%Parameters: Is = imput bwimage; threshold = segment threshold.
Is1 = bwdist(imcomplement(Is)); % inverse Image Then Euclidea distance
Is1 = (mat2gray(Is1)); % double 
[c,h] = imcontour(Is1,0.2:0.1:1);
Is2 = imimposemin(imcomplement(Is1),Is1>threshold);
sw = watershed(Is2);
sw = sw & Is;

end