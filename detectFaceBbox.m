function [ faceBboxL,faceBboxR ] = detectFaceBbox( grayL,grayR,faceDetector )
%DETECTFACE ���E�̃J�����摜�Ŋ�̈�����o����
%
%   [ faceBbox ] = detectFaceBbox( grayL,grayR,frontalFaceDetector,profileFaceDetector,camera )
%
%   input
%   grayL : ���O���[�摜
%   grayR : �E�O���[�摜
%   frontalFaceDetector : �猟�o��
%
%   output
%   faceBboxL : ��̈� [x,y,width,height]
%   faceBboxR : ��̈� [x,y,width,height]


%% �猟�o
% �猟�o���s��
% �������o���ꂽ�ꍇ�A1�Ԗڂ�bbox�݂̂��̗p

% ��
faceBboxL=step(faceDetector,grayL);

if ~isempty(faceBboxL)
    faceBboxL=faceBboxL(1,:);
end

% �E
faceBboxR=step(faceDetector,grayR);

if ~isempty(faceBboxR)
    faceBboxR=faceBboxR(1,:);
end

%% ��ʒu�̊m�F
% Y���W�̒��S�ʒu���r���ă`�F�b�N����
if ~isempty(faceBboxL) && ~isempty(faceBboxR)
    [faceBboxL,faceBboxR]=checkFaceBbox(faceBboxL,faceBboxR);
end

end

