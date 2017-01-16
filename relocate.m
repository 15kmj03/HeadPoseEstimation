function [ xyzPoints ] = relocate( xyzPoints, stereoParams )
%RELOCATE この関数の概要をここに記述
%   詳細説明をここに記述

t=stereoParams.TranslationOfCamera2;

xyzPoints=-xyzPoints;
xyzPoints(:,:,1)=xyzPoints(:,:,1)-t(1);
xyzPoints(:,:,2)=xyzPoints(:,:,2)-t(2);
xyzPoints(:,:,3)=xyzPoints(:,:,3)-t(3);
end

