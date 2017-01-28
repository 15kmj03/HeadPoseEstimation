function [ disparityMap ] = disparityBbox( grayL, grayR, bbox,...
    minDisparity, camera )
%DISPARITYBBOX Bbox領域内の視差を計算する
% 	bbox領域内のみを計算する
%   メディアンフィルタ処理
% 	bbox領域で切り出した画像をscale倍に縮小して計算コスト減
% 	視差計算結果の大きさを元に戻す
% 	最終的な戻り値の大きさは左カメラ画像の大きさ，
%   右カメラ画像の大きさと等しい
%
%   [ disparityMap ] = disparityBbox( imgL, imgR, bbox, dispRange )
%
%   input
%   imgL : 左カメラ画像
%   imgR : 右カメラ画像
%   bbox : 顔領域
%   dispRange : 視差計算範囲
%
%   output
%   disparityMap : 視差画像

%%
% scale=0.5;

x=bbox(1);  % x
y=bbox(2);  % y
w=bbox(3);  % width
h=bbox(4);  % height

bm = cv.StereoSGBM('BlockSize',5,'P1',100,'P2',1600,...
    'UniquenessRatio',1);

switch camera
    case 1
        disparityMap=ones(size(grayL))*-realmax('single');
        ROIL=grayL(y:y+h,1:x+w);
        ROIR=grayR(y:y+h,1:x+w);
        
        bm.MinDisparity=minDisparity;
        dispMapROI=bm.compute(ROIL, ROIR);
        dispMapROI=single(dispMapROI)/16;
        
        dispMapROI(dispMapROI<min(dispMapROI(:))+10)=...
            min(dispMapROI(:));
        
        disparityMap(y:y+h,x:x+w)=dispMapROI(:,x:x+w);
        
    case 2
        disparityMap=ones(size(grayL))*realmax('single');
        ROIL=grayL(y:y+h,x:end);
        ROIR=grayR(y:y+h,x:end);
        
        bm.MinDisparity=-(minDisparity+64);
        dispMapROI=bm.compute(ROIR, ROIL);
        dispMapROI=single(dispMapROI)/16;
        
        dispMapROI(dispMapROI<min(dispMapROI(:))+10)=...
            max(dispMapROI(:));
        
        disparityMap(y:y+h,x:x+w)=dispMapROI(:,1:1+w);
    otherwise
        error('error')
end

% figure
% imshow(dispMapROI,[minDisparity,minDisparity+64],'ColorMap',jet)
% imshow(dispMapROI,[-minDisparity-64,-minDisparity],'ColorMap',jet)
end
