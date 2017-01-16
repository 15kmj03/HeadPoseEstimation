function [ stereoParams,ROIBbox ] = modifyStereoParams( stereoParams,faceBbox )
%MODIFYSTEREOPARAMS ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q

%% �X�e���I�摜��ROI��ݒ�
PP=stereoParams.CameraParameters1.PrincipalPoint;

y=faceBbox(2);
h=faceBbox(4);

xx=1;
yy=y-round(h/2);
ww=2047;
hh=2*h;

% �����ȃC���f�b�N�X���Q�Ƃ��Ȃ��悤�ɒ���
if yy<1
    yy=1;
end
if yy+hh>768
    hh=768-yy;
end

% �摜���S���܂ނ悤�ɒ���
if PP(2)<yy
    yy=floor(PP(2));
end

if PP(2)>yy+hh
    hh=ceil(pp(2)-yy);
end   

ROIBbox=[xx,yy,ww,hh];

%% ROI�ɍ��킹�ăX�e���I�p�����[�^�[�𒲐�
params = toStruct(stereoParams);

params.CameraParameters1.IntrinsicMatrix(3,2)=params.CameraParameters1.IntrinsicMatrix(3,2)-(yy-1);
params.CameraParameters2.IntrinsicMatrix(3,2)=params.CameraParameters2.IntrinsicMatrix(3,2)-(yy-1);

stereoParams = stereoParameters(params);
end

