function [ camera ] = setCamera( faceBboxL,faceBboxR,prevYaw )
%SETCAMERA 3���������̊�J������ݒ肷��
%   
%   input
%   faceBboxL : ���J�����Ō��o���ꂽ��̈��bbox
%   faceBboxR : �E�J�����Ō��o���ꂽ��̈��bbox
%   prevBeta : �O�t���[���Ő��肵�����[�p
%
%   output
%   camera : ��J����

%%

% ���E�̃J�����Ō��o����Ȃ���
if isempty(faceBboxL) && isempty(faceBboxR)
    camera=nan;
    return
end

% ���E�̃J�����Ō��o����Ă��鎞�AprevYaw�ŏꍇ����
if ~isempty(faceBboxL) && ~isempty(faceBboxR)
%     if prevYaw>=0
%         camera=1;
%         return
%     else
%         camera=2;
%         return
%     end
%
%   ���J������3�����������ʂ��������߉E�J�������g�p����
    camera=2;
    return
end

% ���̃J�����Ō��o����Ă��鎞
if ~isempty(faceBboxL)
    camera = 1;
    return
else
    % �E�J�����Ō��o����Ă��鎞
    camera=2;
    return
end

end