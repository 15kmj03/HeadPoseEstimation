function [ disparityMap ] = disparityBbox( grayL, grayR, bbox,...
    minDisparity, camera )
%DISPARITYBBOX Bbox�̈���̎������v�Z����
% 	bbox�̈���݂̂��v�Z����
%   ���f�B�A���t�B���^����
% 	bbox�̈�Ő؂�o�����摜��scale�{�ɏk�����Čv�Z�R�X�g��
% 	�����v�Z���ʂ̑傫�������ɖ߂�
% 	�ŏI�I�Ȗ߂�l�̑傫���͍��J�����摜�̑傫���C
%   �E�J�����摜�̑傫���Ɠ�����
%
%   [ disparityMap ] = disparityBbox( imgL, imgR, bbox, dispRange )
%
%   input
%   imgL : ���J�����摜
%   imgR : �E�J�����摜
%   bbox : ��̈�
%   dispRange : �����v�Z�͈�
%
%   output
%   disparityMap : �����摜

%%
% scale=0.5;

x=bbox(1);  % x
y=bbox(2);  % y
w=bbox(3);  % width
h=bbox(4);  % height

bm = cv.StereoSGBM('BlockSize',5,'P1',100,'P2',1600,...
    'UniquenessRatio',1);

switch camera
    case 1
        disparityMap=ones(size(grayL))*-realmax('single');
        ROIL=grayL(y:y+h,1:x+w);
        ROIR=grayR(y:y+h,1:x+w);
        
        bm.MinDisparity=minDisparity;
        dispMapROI=bm.compute(ROIL, ROIR);
        dispMapROI=single(dispMapROI)/16;
        
        dispMapROI(dispMapROI<min(dispMapROI(:))+10)=...
            min(dispMapROI(:));
        
        disparityMap(y:y+h,x:x+w)=dispMapROI(:,x:x+w);
        
    case 2
        disparityMap=ones(size(grayL))*realmax('single');
        ROIL=grayL(y:y+h,x:end);
        ROIR=grayR(y:y+h,x:end);
        
        bm.MinDisparity=-(minDisparity+64);
        dispMapROI=bm.compute(ROIR, ROIL);
        dispMapROI=single(dispMapROI)/16;
        
        dispMapROI(dispMapROI<min(dispMapROI(:))+10)=...
            max(dispMapROI(:));
        
        disparityMap(y:y+h,x:x+w)=dispMapROI(:,1:1+w);
    otherwise
        error('error')
end

% figure
% imshow(dispMapROI,[minDisparity,minDisparity+64],'ColorMap',jet)
% imshow(dispMapROI,[-minDisparity-64,-minDisparity],'ColorMap',jet)
end
