function [ nxyz ] = separateXyzPoints( xyzPoints,n )
%SEPARATEXYZPOINTS xyzPointsをn分割する
%   詳細説明をここに記述

%% インデックス行列作成
yy=zeros(1,n*2);
h=floor(size(xyzPoints,1)/n)-1;
yy(1)=1;

for i=2:n*2
    if rem(i,2)
        yy(i)=yy(i-1)+1;
    else
        yy(i)=yy(i-1)+h;
    end
end

%% 分割
nxyz=cell(n,1);
for i=1:n
    nxyz{i}=xyzPoints(yy(i*2-1):yy(i*2),:,:);
end

end

