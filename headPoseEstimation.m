function [ pitches,yaws,rolls,Xs,Ys,Zs ] = headPoseEstimation( filename )
%HEADPOSEESTIMATION 頭部姿勢変化推定を行う
%
%   [ pitches,yaws,rolls ] = headPoseEstimation( filename )
%
% input
% filename : 動画ファイル名
%
% output
% pitches : ピッチ角変化
% yaws : ヨー角変化
% rolls : ロール角変化
% Xs : X座標変化
% Ys : Y座標変化
% Zs : Z座標変化
%
%
% mexopencvの関数を利用する
% mexopencvを利用できる環境を構築する必要あり
%
% グローバル座標系で左カメラの位置を原点とする
% 右手座標系
%
% フレームごとに3次元処理の基準となるカメラを選択し、切り替える
% ヨー角度が正...右カメラ画像を使用
% ヨー角度が負...左カメラ画像を使用
% ヨー角度の符号は首を右に振る方向が正、左に振る方向が負
%
% ステレオパラメーター中のカメラ番号
% 1:左カメラ
% 2:右カメラ
%
% windowsでvision.VideoFileReaderを使用してmp4ファイルを読み込むとき、
% matlab.video.read.UseHardwareAcceleration('off')を実行したほうが
% 高速になることがある


%% 初期設定

frameIdx=0;
prevBbox=[];

% 動画読み込み
videoFileReader=vision.VideoFileReader(filename,...
    'VideoOutputDataType', 'uint8');

% ステレオパラメーター読み込み
load('stereoParamsL1R2.mat')

% 検出器読み込み
% 検索対象の大きさをの上限、下限を設定
faceDetector = vision.CascadeObjectDetector('ClassificationModel',...
    'FrontalFaceCART', 'MinSize', [200,200], 'MaxSize', [400,400]);


%% 基準顔点群を得る処理

% minDisparityが決定されるまで繰り返す
minDisparity=nan;
while isnan(minDisparity)
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
    minDisparity = determineMinDisparity(grayL, grayR,...
        faceBboxL,faceBboxR);
end

reset(videoFileReader);
frameIdx=0;

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

% 基準カメラの設定
% 角度、顔検出結果に基づいて基準カメラを設定
camera=setCamera(faceBboxL,faceBboxR,0);

% bboxの設定
if ~isnan(camera)
    bbox=setBbox(faceBboxL,faceBboxR,camera,size(imgL));
else
    bbox=prevBbox;
    camera=2;
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

% 点群の3次元座標を左カメラ基準に変更
if camera==2
    xyzPoints=relocate(xyzPoints,stereoParamsL1R2);
end

% 顔と背景の分離
xyzPoints=refineXyzPoints(xyzPoints);
x0=mean(xyzPoints(:,1));
y0=mean(xyzPoints(:,2));
z0=mean(xyzPoints(:,3));

% ptCloudの作成
% ヨーが0度のときのptCloudをface0として保存
ptCloud=pointCloud(xyzPoints);
face0 = pcdownsample(ptCloud, 'random', 0.1);
faceMaxYaw = pointCloud([NaN,NaN,NaN]);
faceMinYaw = pointCloud([NaN,NaN,NaN]);
face = face0;

% 角度
tform = affine3d;
pitches(frameIdx) = 0;
yaws(frameIdx) = 0;
rolls(frameIdx) = 0;

% prevの設定
prevTform=tform;
prevCamera=camera;
prevBbox=bbox;

% ROIの設定、ステレオパラメータの辻褄を合わせる
switch camera
    case 1
        [stereoParamsL1R2, ROI] = modifyStereoParams(...
            stereoParamsL1R2, faceBboxL);
    case 2
        [stereoParamsL1R2, ROI] = modifyStereoParams(...
            stereoParamsL1R2, faceBboxR);
end

% bboxの位置を更新
prevBbox(2)=prevBbox(2)-ROI(2)-1;

%% ループ
while 1
    
    %% 1フレーム読み込み
    [rawStereoImg, EOF] = step(videoFileReader);
    frameIdx = frameIdx+1;
    display(frameIdx)
    
    %% ROI領域のみを切り取る
    rawStereoImg = bbox2ROI(rawStereoImg, ROI);
    
    %% 歪み頬正
    [imgL, imgR] = undistortAndRectifyStereoImage(rawStereoImg,...
        stereoParamsL1R2);
    
    %% グレースケール変換
    grayL = rgb2gray(imgL);
    grayR = rgb2gray(imgR);
    
    %% 顔検出
    % 左右のカメラ画像で顔検出を行う
    [faceBboxL,faceBboxR] = detectFaceBbox(grayL, grayR,...
        faceDetector);
    
    %% 基準カメラの設定
    % 角度、顔検出結果に基づいて基準カメラを設定
    camera=setCamera(faceBboxL,faceBboxR,yaws(frameIdx-1));
    
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
    % 最終的な戻り値の大きさは左カメラ画像の大きさ、
    % 右カメラ画像の大きさと等しい
    dispMap = disparityBbox(grayL, grayR, bbox, minDisparity, camera);
    
    %% 3次元座標計算
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
    ptCloud=pointCloud(xyzPoints);
%     pcshow(ptCloud, 'VerticalAxis', 'Y', 'VerticalAxisDir', 'Down')
%     xlabel('X [mm]')
%     ylabel('Y [mm]')
%     zlabel('Z [mm]')
%     drawnow;
    
    %% registration
    mergeSize = 3;
    
    new = pcdownsample(ptCloud, 'random', 0.1);
    disp(new.Count)
    tform = pcregrigid(new, face, 'Metric', 'pointToPlane',...
        'Extrapolate', true, 'InitialTransform', prevTform,...
        'MaxIterations', 10, 'InlierRatio', 1);
    
    %% registrationの結果処理
    [tform,pitch,yaw,roll]=checkTform(tform,prevTform);
    
    maxYaw=max(yaws);
    minYaw=min(yaws);
    
    pitches(frameIdx) = pitch;
    yaws(frameIdx) = yaw;
    rolls(frameIdx) = roll;
    
    x=mean(xyzPoints(:,1));
    y=mean(xyzPoints(:,2));
    z=mean(xyzPoints(:,3));
    
    Xs(frameIdx)=x0-x;
    Ys(frameIdx)=y0-y;
    Zs(frameIdx)=z0-z;

    % 基準顔点群の更新
    if yaw > maxYaw
        faceMaxYaw = pctransform(new, tform);
        faceMearge = pcmerge(faceMaxYaw, faceMinYaw, mergeSize);
        face = pcmerge(face0, faceMearge, mergeSize);
    end
    if yaw < minYaw
        faceMinYaw = pctransform(new, tform);
        faceMearge=pcmerge(faceMaxYaw, faceMinYaw, mergeSize);
        face = pcmerge(face0, faceMearge, mergeSize);
    end        

    %% EOFの確認
    if EOF
        break
    end
    
    %% prevの設定
    prevTform=tform;
    prevCamera=camera;
    prevBbox=bbox;
    
end

end

