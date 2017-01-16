close all
clear
clc

% 頭部姿勢角度の変化を推定する関数

% グローバル座標系で左カメラの位置を原点とする
% 右手座標系

% フレームごとに処理の基準となるカメラを選択し、切り替える
% ヨー角度の符号は首を右に振る方向が正、左に振る方向が負
% ヨー角度が正...右カメラ画像を使用
% ヨー角度が負...左カメラ画像を使用

% windowsでvision.VideoFileReaderを使用してmp4ファイルを読み込むとき、
% matlab.video.read.UseHardwareAcceleration('off')を実行したほうが
% 高速になることがある

%% 1回のみ

frameIdx=0;
prevBbox=[];
pitches=zeros(301,1);
yaws=zeros(301,1);
rollss=zeros(301,1);

% 動画読み込み
videoFileReader=vision.VideoFileReader('F:\tutiya\2.avi',...
    'VideoOutputDataType', 'uint8');

% ステレオパラメーター読み込み
load('stereoParamsL1R2.mat')

% 検出器読み込み
% 検索対象の大きさをの上限、下限を設定
faceDetector = vision.CascadeObjectDetector('ClassificationModel',...
    'FrontalFaceCART', 'MinSize', [200,200], 'MaxSize', [400,400]);

% 1フレーム読み込み
[rawStereoImg, EOF] = step(videoFileReader);
frameIdx = frameIdx+1;
display(frameIdx)

% 歪み頬正
[imgL, imgR] = undistortAndRectifyStereoImage(rawStereoImg,...
    stereoParamsL1R2);

% グレースケール変換
grayL = rgb2gray(imgL);
grayR = rgb2gray(imgR);

% 顔検出
% 左右のカメラ画像で顔検出を行う
[faceBboxL,faceBboxR] = detectFaceBbox(grayL, grayR, faceDetector);

% minDisparityの設定
minDisparity = determineMinDisparity(grayL, grayR, faceBboxL,faceBboxR);

% 基準カメラの設定
% 角度、顔検出結果に基づいて基準カメラを設定
camera=setCamera(faceBboxL,faceBboxR,0);

% bboxの設定
if ~isnan(camera)
    bbox=setBbox(faceBboxL,faceBboxR,camera,size(imgL));
else
    bbox=prevBbox;
    camera=prevCamera;
end

% 視差計算
% bbox領域内のみを計算する
% 最終的な戻り値の大きさは左カメラ画像の大きさ、右カメラ画像の大きさと等しい
dispMap = disparityBbox(grayL, grayR, bbox, minDisparity, camera);

% 3次元座標計算
% L1R2のステレオパラメータで3次元計算
% bbox領域内のみで切り出す
% 最終的な戻り値の大きさはbboxの大きさと等しい
xyzPoints = reconstructScene(dispMap, stereoParamsL1R2);
xyzPoints=bbox2ROI(xyzPoints,bbox);

% 3次元座標を左カメラ基準に変更
if camera==2
    xyzPoints=relocate(xyzPoints,stereoParamsL1R2);
end

% 顔と背景の分離
xyzPoints=refineXyzPoints(xyzPoints);

% ptCloudの作成
% 	ヨーが0度のときのptCloudをface0として保存
ptCloud=pointCloud(xyzPoints);
figure(99);
pcshow(ptCloud, 'VerticalAxis', 'Y', 'VerticalAxisDir', 'Down')
title('ptCloud');
drawnow

% prevの設定
prevCamera=camera;
prevBbox=bbox;

% ROIの設定、ステレオパラメータの辻褄を合わせる
switch camera
    case 1
        [stereoParamsL1R2, ROI] = modifyStereoParams(stereoParamsL1R2, faceBboxL);
    case 2
        [stereoParamsL1R2, ROI] = modifyStereoParams(stereoParamsL1R2, faceBboxR);
end

% bboxの位置を更新
prevBbox(2)=prevBbox(2)-ROI(2)-1;

%% ループ
while 1
%     tic
    
    %% 1フレーム読み込み
    [rawStereoImg, EOF] = step(videoFileReader);
    frameIdx = frameIdx+1;
    display(frameIdx)
    if (frameIdx==50)
    end
    
    %% 歪み頬正
    [imgL, imgR] = undistortAndRectifyStereoImage(rawStereoImg,...
        stereoParamsL1R2);
    
    %% グレースケール変換
    grayL = rgb2gray(imgL);
    grayR = rgb2gray(imgR);
    
    %% 顔検出
    % 左右のカメラ画像で顔検出を行う
    [faceBboxL,faceBboxR] = detectFaceBbox(grayL, grayR, faceDetector);
    
    %% 基準カメラの設定
    % 角度、顔検出結果に基づいて基準カメラを設定
    camera=setCamera(faceBboxL,faceBboxR,0);
    
    %% bboxの設定
    if ~isnan(camera)
        bbox=setBbox(faceBboxL,faceBboxR,camera,size(imgL));
    else
        disp('prevBbox')
        bbox=prevBbox;
        camera=prevCamera;
    end
    
    %% 視差計算
    % bbox領域内のみを計算する
    % 最終的な戻り値の大きさは左カメラ画像の大きさ、右カメラ画像の大きさと等しい
    dispMap = disparityBbox(grayL, grayR, bbox, minDisparity, camera);
    
    %% 3次元座標計算
    % L1R2のステレオパラメータで3次元計算
    % bbox領域内のみで切り出す
    % 最終的な戻り値の大きさはbboxの大きさと等しい
    xyzPoints = reconstructScene(dispMap, stereoParamsL1R2);
    xyzPoints=bbox2ROI(xyzPoints,bbox);
    
    %% 3次元座標を左カメラ基準に変更
    if camera==2
        xyzPoints=relocate(xyzPoints,stereoParamsL1R2);
    end
    
    %% 顔と背景の分離
    xyzPoints=refineXyzPoints(xyzPoints);
        
    %% ptCloudの作成
    % 	ヨーが0度のときのptCloudをface0として保存
    ptCloud=pointCloud(xyzPoints);
        figure(99);
        pcshow(ptCloud, 'VerticalAxis', 'Y', 'VerticalAxisDir', 'Down')
        title('ptCloud');
        drawnow
    
    %% EOFの確認
    if EOF
        break
    end
    
    %% prevの設定
    prevCamera=camera;
    prevBbox=bbox;
    
    %%
%     toc
end