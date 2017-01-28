function [ bbox ] = checkBbox( bbox, imageSize )
%CHECKBBOX bboxが正常であることを確認する
%
%   input
%   bbox : 確認前のbbox
%   imageSize : 画像サイズ
%
%   output
%   bbox : 確認後のbbox
%%

rows=imageSize(1);
cols=imageSize(2);

x=bbox(1);
y=bbox(2);
w=bbox(3);
h=bbox(4);

if x<1
    bbox(1)=1;
end

if y<1
    bbox(2)=1;
end

if x+w>cols
    bbox(3)=cols-x;
end

if y+h>rows
    bbox(4)=rows-y;
end

end