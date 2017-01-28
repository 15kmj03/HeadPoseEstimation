function [ nxyz ] = separateXyzPoints( xyzPoints,n )
%SEPARATEXYZPOINTS xyzPointsをn分割する
%
%   [ nxyz ] = separateXyzPoints( xyzPoints,n )
%
%   input
%   xyzPoints : 点群の3次元座標
%
%   output
%   nxyz : n分割された3次元座標

%% インデックス行列作成
yy=zeros(1,n*2);
h=floor(size(xyzPoints,1)/n)-1;

yy(1:2:n*2)=1:h+1:(h+1)*n;
yy(2:2:n*2)=h+1:h+1:(h+1)*n;

%% 分割
nxyz=cell(n,1);
for i=1:n
    xyz=xyzPoints(yy(i*2-1):yy(i*2),:,:);
    
    xval=xyz(:,:,1);
    yval=xyz(:,:,2);
    zval=xyz(:,:,3);
    
    xval=xval(~isnan(zval));
    yval=yval(~isnan(zval));
    zval=zval(~isnan(zval));
    
    sortedxyz=sortrows([xval,yval,zval]);
    
    nxyz{i}=sortedxyz;
end

end