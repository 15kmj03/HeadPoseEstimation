function [ stereoParams,ROIBbox ] = modifyStereoParams( stereoParams,faceBbox )
%MODIFYSTEREOPARAMS この関数の概要をここに記述
%   詳細説明をここに記述

%% ステレオ画像のROIを設定
PP=stereoParams.CameraParameters1.PrincipalPoint;

y=faceBbox(2);
h=faceBbox(4);

xx=1;
yy=y-round(h/2);
ww=2047;
hh=2*h;

% 無効なインデックスを参照しないように調整
if yy<1
    yy=1;
end
if yy+hh>768
    hh=768-yy;
end

% 画像中心を含むように調整
if PP(2)<yy
    yy=floor(PP(2));
end

if PP(2)>yy+hh
    hh=ceil(pp(2)-yy);
end   

ROIBbox=[xx,yy,ww,hh];

%% ROIに合わせてステレオパラメーターを調整
params = toStruct(stereoParams);

params.CameraParameters1.IntrinsicMatrix(3,2)=params.CameraParameters1.IntrinsicMatrix(3,2)-(yy-1);
params.CameraParameters2.IntrinsicMatrix(3,2)=params.CameraParameters2.IntrinsicMatrix(3,2)-(yy-1);

stereoParams = stereoParameters(params);
end

