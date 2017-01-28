function [ camera ] = setCamera( faceBboxL,faceBboxR,prevYaw )
%SETCAMERA 3次元復元の基準カメラを設定する
%   
%   input
%   faceBboxL : 左カメラで検出された顔領域のbbox
%   faceBboxR : 右カメラで検出された顔領域のbbox
%   prevBeta : 前フレームで推定したヨー角
%
%   output
%   camera : 基準カメラ

%%

% 左右のカメラで検出されない時
if isempty(faceBboxL) && isempty(faceBboxR)
    camera=nan;
    return
end

% 左右のカメラで検出されている時、prevYawで場合分け
if ~isempty(faceBboxL) && ~isempty(faceBboxR)
%     if prevYaw>=0
%         camera=1;
%         return
%     else
%         camera=2;
%         return
%     end
%
%   左カメラの3次元復元結果が悪いため右カメラを使用する
    camera=2;
    return
end

% 左のカメラで検出されている時
if ~isempty(faceBboxL)
    camera = 1;
    return
else
    % 右カメラで検出されている時
    camera=2;
    return
end

end