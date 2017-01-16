function [ img1,img2 ] = splitStereoImage( stereoImage )
%SPLITSTEREOIMAGE ステレオ画像を左右に分割する関数
%
%   [ img1,img2 ] = splitStereoImage( stereoImage )
%
%   input
%   stereoImage : ステレオ画像
%
%   output
%   img1 : stereoImage上で左にある画像
%   img2 : stereoImage上で右にある画像

%% ステレオ画像を左右に分割
[~, cols, ~] = size(stereoImage);           % サイズ確認

% 分割
img1 = stereoImage(:, 1:cols/2, :);
img2 = stereoImage(:, cols/2+1:cols, :);

end

