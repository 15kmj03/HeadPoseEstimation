function [ camera ] = setCamera( faceBboxL,faceBboxR,prevBeta )
%SETCAMERA ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q

%%

% ���E�̃J�����Ō��o����Ȃ���
if isempty(faceBboxL) && isempty(faceBboxR)
    camera=nan;
    return
end

% ���E�̃J�����Ō��o����Ă��鎞�AprevBeta�ŏꍇ����
if ~isempty(faceBboxL) && ~isempty(faceBboxR)
    if prevBeta>=0
        camera=1;
        return
    else
        camera=2;
        return
    end
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

