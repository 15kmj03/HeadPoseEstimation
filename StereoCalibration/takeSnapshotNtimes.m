function [  ] = takeSnapshotNtimes( n )
%TAKESNAPSHOTNTIMES n枚画像を撮影する関数
%
%   [  ] = takeSnapshotNtimes( n )

% PGRカメラと接続を行う
vidObj=conectToPGRCamera();

% プレビューを開始
preview(vidObj)

% n枚画像を撮影する
for idx=1:n
    % ファイル名
    idxnumber = num2str(idx);
    extension = '.png';
    filename = ['raw',idxnumber,extension];
    
    % キーボード又はマウスのイベントを待つ
    waitforbuttonpress
    
    % 画像を撮影
    snapshot = getsnapshot(vidObj);
    imwrite(snapshot,filename)
end

% プレビューを停止
closepreview(vidObj)

% PGRカメラとの接続を切る
disconectToPGRCamera(vidObj);

close all;
clear
end

