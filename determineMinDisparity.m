function [ minDisparity ] = determineMinDisparity( grayL,grayR,...
    bboxL,bboxR )
%DETERMINEDISPARITYRANGE ���������͈͂̍ŏ��l�����肷��
%
%   [ minDisparity ] = determineMinDisparity( grayL,grayR,bbox )
%
%   input
%   grayL : ���O���[�摜
%   grayR : �E�O���[�摜
%   bbox : bounding box
%
%   output
%   minDisparity : ���������͈͂̍ŏ��l
%
%                ���������͈�[pix]
%      |----------disparityRange----------|
%     min              disp              max
%   disp-32            disp            disp+32
% disparityRange��16�̔{���ł���K�v����

%% disparity�̌v�Z

if ~isempty(bboxL)
    disp=calculateDisparity(grayL,grayR,bboxL,1);
else
    if ~isempty(bboxR)
        disp=calculateDisparity(grayL,grayR,bboxR,2);
    else
        minDisparity=nan;
        return
    end    
end

%% minDisparity�̐ݒ�
minDisparity=disp-(8*4);
    
end