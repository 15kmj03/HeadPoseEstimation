% ステレオ画像を連続でn枚読み込み、分割して保存するスクリプト

% 画像の枚数
n=10;

for idx=1:n
    % ファイル名
    idxnumber = num2str(idx);
    extension = '.png';
    loadFilename = ['raw',idxnumber,extension];
    saveFilename1=['R/',idxnumber,extension]
    saveFilename2=['L/',idxnumber,extension]

    % 読み込み
    stereoImage = imread(loadFilename);

    % 分割
    [img1,img2] = splitStereoImage(stereoImage);

    % 保存
    imwrite(img1,saveFilename1);
    imwrite(img2,saveFilename2);
end