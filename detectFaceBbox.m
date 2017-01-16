function [ faceBboxL,faceBboxR ] = detectFaceBbox( grayL,grayR,faceDetector )
%DETECTFACE 左右のカメラ画像で顔領域を検出する
%
%   [ faceBbox ] = detectFaceBbox( grayL,grayR,frontalFaceDetector,profileFaceDetector,camera )
%
%   input
%   grayL : 左グレー画像
%   grayR : 右グレー画像
%   frontalFaceDetector : 顔検出器
%
%   output
%   faceBboxL : 顔領域 [x,y,width,height]
%   faceBboxR : 顔領域 [x,y,width,height]


%% 顔検出
% 顔検出を行う
% 複数検出された場合、1番目のbboxのみを採用

% 左
faceBboxL=step(faceDetector,grayL);

if ~isempty(faceBboxL)
    faceBboxL=faceBboxL(1,:);
end

% 右
faceBboxR=step(faceDetector,grayR);

if ~isempty(faceBboxR)
    faceBboxR=faceBboxR(1,:);
end

%% 顔位置の確認
% Y座標の中心位置を比較してチェックする
if ~isempty(faceBboxL) && ~isempty(faceBboxR)
    [faceBboxL,faceBboxR]=checkFaceBbox(faceBboxL,faceBboxR);
end

end

