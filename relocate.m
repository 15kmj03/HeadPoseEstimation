function [ xyzPoints ] = relocate( xyzPoints, stereoParams )
%RELOCATE 3次元座標を左カメラ基準に変更
%
% [ xyzPoints ] = relocate( xyzPoints, stereoParams )
%
%   input
%   xyzPoints : 3次元復元された座標
%   stereoParams : カメラパラメータ
%
%   output
%   xyzPoints : 左カメラを基準とした3次元座標

%%
t=stereoParams.TranslationOfCamera2;

xyzPoints=-xyzPoints;
xyzPoints(:,:,1)=xyzPoints(:,:,1)-t(1);
xyzPoints(:,:,2)=xyzPoints(:,:,2)-t(2);
xyzPoints(:,:,3)=xyzPoints(:,:,3)-t(3);
end

