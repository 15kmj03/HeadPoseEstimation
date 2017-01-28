function [ disparity ] = calculateDisparity( grayL,grayR,bbox,camera )
%CALCULATEDISPARITY bbox�̈�̎������v�Z����
%
%   [ disparity ] = calculateDisparity( grayL,grayR,bbox )
%
%   input
%   grayL : ���O���[�摜
%   grayR : �E�O���[�摜
%   bbox : bounding box
%
%   output
%   disparity : ����

%%

imgSize=size(grayL);

x=bbox(1);  % x
y=bbox(2);  % y
w=bbox(3);  % width
h=bbox(4);  % height

switch camera
    case 1
        absdiff=zeros(1,x); % ���̑��a��ۑ�����ׂ̕ϐ�
        
        imgFace=bbox2ROI(grayL,bbox);  % bbox�̈��؂�o��
        
        for i=1:x
            % ROI�̐ݒ�
            bboxROI=[i,y,w,h];
            % ROI�̈��؂�o��
            ROI=bbox2ROI(grayR,bboxROI);
            % ���̑��a���v�Z
            absdiff(i)=sum(sum(imabsdiff(imgFace,ROI)));
        end
        
        [~,I]=min(absdiff); % �ŏ��̃C���f�b�N�X��T��
        
        disparity=abs(x-I);
        
    case 2
        absdiff=zeros(1,imgSize(2)-w); % ���̑��a��ۑ�����ׂ̕ϐ�
        
        imgFace=bbox2ROI(grayR,bbox);  % bbox�̈��؂�o��
        
        for i=x:imgSize(2)-w
            % ROI�̐ݒ�
            bboxROI=[i,y,w,h];
            % ROI�̈��؂�o��
            ROI=bbox2ROI(grayL,bboxROI);
            % ���̑��a���v�Z
            absdiff(i)=sum(sum(imabsdiff(imgFace,ROI)));
            
        end
        [~,I]=min(absdiff(x:end)); % �ŏ��̃C���f�b�N�X��T��
        I=I+x-1;
        
        disparity=abs(x-I);
end

% figure(1)
% plot(absdiff)
%
% figure
% bbox=[I,y,w,h];
% ROI=bbox2ROI(grayL,bbox);
% imshow(ROI)

end

