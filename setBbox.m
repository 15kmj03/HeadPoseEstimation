function [ bbox ] = setBbox( faceBboxL,faceBboxR,camera,imgSize )
%SETBBOX 基準カメラに基いて3次元復元の対象となるbboxを設定する
% 	faceBboxの縦幅20%減
% 	faceBboxの横幅40%増

%% 設定
switch camera
    case 1
        bbox=setBbox1234(faceBboxL);
    case 2
        bbox=setBbox1234(faceBboxR);
    otherwise
        error('error')
end     

%% 	bboxの確認
bbox=checkBbox(bbox,imgSize);

end