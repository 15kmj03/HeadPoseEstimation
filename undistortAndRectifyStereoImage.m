function [ imgL,imgR ] = undistortAndRectifyStereoImage( rawStereoImg,stereoParams )
%UNDISTORTANDRECTIFYSTEREOIMAGE ステレオ画像の歪み補正と平行化を行う
% 	L1R2のステレオパラメータで歪み補正
%
%   [ imgL, imgR ] = undistortAndRectifyStereoImage( rawStereoImg, stereoParamsL1R2 )
%
%   input
%   rawStereoImg : ステレオ画像
%   stereoParamsL1R2 : ステレオカメラのキャリブレーションデータ
%
%   output
%   imgL : 補正された左カメラ画像
%   imgR ; 補正された右カメラ画像
%


%% ステレオ画像の歪み補正と平行化
% 分割
[rawR,rawL] = splitStereoImage(rawStereoImg);

% 歪み補正と平行化
[imgL,imgR] = rectifyStereoImages(rawL, rawR, stereoParams, 'OutputView', 'valid');

end

