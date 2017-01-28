function [ nxyz ] = separateXyzPoints( xyzPoints,n )
%SEPARATEXYZPOINTS xyzPoints��n��������
%
%   [ nxyz ] = separateXyzPoints( xyzPoints,n )
%
%   input
%   xyzPoints : �_�Q��3�������W
%
%   output
%   nxyz : n�������ꂽ3�������W

%% �C���f�b�N�X�s��쐬
yy=zeros(1,n*2);
h=floor(size(xyzPoints,1)/n)-1;

yy(1:2:n*2)=1:h+1:(h+1)*n;
yy(2:2:n*2)=h+1:h+1:(h+1)*n;

%% ����
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