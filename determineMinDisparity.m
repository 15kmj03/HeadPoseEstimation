function [ minDisparity ] = determineMinDisparity( grayL,grayR,bboxL,bboxR )
%DETERMINEDISPARITYRANGE �����̍ŏ��l�����肷��
%   ��1�����͍��J�����摜�A��2�����͉E�J�����摜�ŌŒ�
%
%   [ minDisparity ] = determineMinDisparity( grayL,grayR,bbox )
%
%   input
%   grayL : ���O���[�摜
%   grayR : �E�O���[�摜
%   bbox : bounding box
%
%   output
%   minDisparity : �����̍ŏ��l


%%

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

minDisparity=disp-(8*4);
    
end

