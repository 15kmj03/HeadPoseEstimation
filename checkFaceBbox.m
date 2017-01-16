function [ faceBboxL,faceBboxR ] = checkFaceBbox( faceBboxL,faceBboxR )
%CHECKFACEBBOX faceBboxの確認を行う
%   Y座標の中心位置を比較してチェックする
%%

th=50;
centerYL=faceBboxL(2)+faceBboxL(4)/2;
centerYR=faceBboxR(2)+faceBboxR(4)/2;

if abs(centerYL-centerYR)>th
    faceBboxL=[];
    faceBboxR=[];
end

end

