function [ disparityMap ] = disparityBbox( grayL, grayR, bbox, minDisparity, camera )
%DISPARITYBBOX 左カメラ画像で検出されたBbox領域内の視差を計算する
% 	bbox領域内のみを計算する
%   メディアンフィルタ処理
% 	bbox領域で切り出した画像をscale倍に縮小して計算コスト減
% 	視差計算結果の大きさを元に戻す
% 	最終的な戻り値の大きさは左カメラ画像の大きさ、右カメラ画像の大きさと等しい
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

bm = cv.StereoSGBM('BlockSize',5,'P1',100,'P2',1600,'UniquenessRatio',1);
        disparityMap=ones(size(grayL))*-realmax('single');
        
switch camera
    case 1
        disparityMap=ones(size(grayL))*-realmax('single');
        ROIL=grayL(y:y+h,1:x+w);
        ROIR=grayR(y:y+h,1:x+w);
%         roiSize=size(ROIL);
        
%         ROIL=imresize(ROIL,'scale',[scale,1]);
%         ROIR=imresize(ROIR,'scale',[scale,1]);
        
        bm.MinDisparity=minDisparity;
        dispMapROI=bm.compute(ROIL, ROIR);
        dispMapROI=single(dispMapROI)/16;
        
%         dispMapROI=imresize(dispMapROI,roiSize);
%         dispMapROI=medfilt2(dispMapROI);
                
        disparityMap(y:y+h,x:x+w)=dispMapROI(:,x:x+w);
        
    case 2
        ROIL=grayL(y:y+h,x:end);
        ROIR=grayR(y:y+h,x:end);
%         roiSize=size(ROIL);
        
%         ROIL=imresize(ROIL,'scale',[scale,1]);
%         ROIR=imresize(ROIR,'scale',[scale,1]);
        
        bm.MinDisparity=-(minDisparity+64);
        dispMapROI=bm.compute(ROIR, ROIL);
        dispMapROI=single(dispMapROI)/16;

        dispMapROI(dispMapROI>max(dispMapROI(:))-32)=-realmax('single');
%         dispMapROI=imresize(dispMapROI,roiSize);
%         dispMapROI=medfilt2(dispMapROI,[5,5]);
        
        disparityMap(y:y+h,x:x+w)=dispMapROI(:,1:1+w);
    otherwise
        error('error')
end

% figure
% imshow(disparityMap,[minDisparity,minDisparity+64],'ColorMap',jet)
% imshow(disparityMap,[-minDisparity-64,-minDisparity],'ColorMap',jet)
end
