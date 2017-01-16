function [ disparityMap ] = disparityBbox( grayL, grayR, bbox, minDisparity, camera )
%DISPARITYBBOX ���J�����摜�Ō��o���ꂽBbox�̈���̎������v�Z����
% 	bbox�̈���݂̂��v�Z����
%   ���f�B�A���t�B���^����
% 	bbox�̈�Ő؂�o�����摜��scale�{�ɏk�����Čv�Z�R�X�g��
% 	�����v�Z���ʂ̑傫�������ɖ߂�
% 	�ŏI�I�Ȗ߂�l�̑傫���͍��J�����摜�̑傫���A�E�J�����摜�̑傫���Ɠ�����
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

bm = cv.StereoSGBM('BlockSize',5,'P1',100,'P2',1600,'UniquenessRatio',1);
        disparityMap=ones(size(grayL))*-realmax('single');
        
switch camera
    case 1
        disparityMap=ones(size(grayL))*-realmax('single');
        ROIL=grayL(y:y+h,1:x+w);
        ROIR=grayR(y:y+h,1:x+w);
%         roiSize=size(ROIL);
        
%         ROIL=imresize(ROIL,'scale',[scale,1]);
%         ROIR=imresize(ROIR,'scale',[scale,1]);
        
        bm.MinDisparity=minDisparity;
        dispMapROI=bm.compute(ROIL, ROIR);
        dispMapROI=single(dispMapROI)/16;
        
%         dispMapROI=imresize(dispMapROI,roiSize);
%         dispMapROI=medfilt2(dispMapROI);
                
        disparityMap(y:y+h,x:x+w)=dispMapROI(:,x:x+w);
        
    case 2
        ROIL=grayL(y:y+h,x:end);
        ROIR=grayR(y:y+h,x:end);
%         roiSize=size(ROIL);
        
%         ROIL=imresize(ROIL,'scale',[scale,1]);
%         ROIR=imresize(ROIR,'scale',[scale,1]);
        
        bm.MinDisparity=-(minDisparity+64);
        dispMapROI=bm.compute(ROIR, ROIL);
        dispMapROI=single(dispMapROI)/16;

        dispMapROI(dispMapROI>max(dispMapROI(:))-32)=-realmax('single');
%         dispMapROI=imresize(dispMapROI,roiSize);
%         dispMapROI=medfilt2(dispMapROI,[5,5]);
        
        disparityMap(y:y+h,x:x+w)=dispMapROI(:,1:1+w);
    otherwise
        error('error')
end

% figure
% imshow(disparityMap,[minDisparity,minDisparity+64],'ColorMap',jet)
% imshow(disparityMap,[-minDisparity-64,-minDisparity],'ColorMap',jet)
end
