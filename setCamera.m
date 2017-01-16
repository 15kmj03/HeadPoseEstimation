function [ camera ] = setCamera( faceBboxL,faceBboxR,prevBeta )
%SETCAMERA この関数の概要をここに記述
%   詳細説明をここに記述

%%

% 左右のカメラで検出されない時
if isempty(faceBboxL) && isempty(faceBboxR)
    camera=nan;
    return
end

% 左右のカメラで検出されている時、prevBetaで場合分け
if ~isempty(faceBboxL) && ~isempty(faceBboxR)
    if prevBeta>=0
        camera=1;
        return
    else
        camera=2;
        return
    end
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

