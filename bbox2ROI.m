function [ ROI ] = bbox2ROI( img,bbox )
%BBOX2ROI 画像からbbox部分のみを切り出す
%
%   [ ROI ] = bbox2ROI( img,bbox )
%
%   input
%   img : 画像
%   bbox : bounding box
%
%   output
%   ROI : region of interest

%%
x=bbox(1);  % x
y=bbox(2);  % y
w=bbox(3);  % width
h=bbox(4);  % height

ROI=img(y:y+h,x:x+w,:);

end

