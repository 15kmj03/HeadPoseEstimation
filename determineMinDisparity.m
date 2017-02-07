function [ minDisparity ] = determineMinDisparity( grayL,grayR,...
    bboxL,bboxR )
%DETERMINEDISPARITYRANGE 視差検索範囲の最小値を決定する
%
%   [ minDisparity ] = determineMinDisparity( grayL,grayR,bbox )
%
%   input
%   grayL : 左グレー画像
%   grayR : 右グレー画像
%   bbox : bounding box
%
%   output
%   minDisparity : 視差検索範囲の最小値
%
%                視差検索範囲[pix]
%      |----------disparityRange----------|
%     min              disp              max
%   disp-32            disp            disp+32
% disparityRangeは16の倍数である必要あり

%% disparityの計算

if ~isempty(bboxL)
    disp=calculateDisparity(grayL,grayR,bboxL,1);
else
    if ~isempty(bboxR)
        disp=calculateDisparity(grayL,grayR,bboxR,2);
    else
        minDisparity=nan;
        return
    end    
end

%% minDisparityの設定
minDisparity=disp-(8*4);
    
end