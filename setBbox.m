function [ bbox ] = setBbox( faceBboxL,faceBboxR,camera,imgSize )
%SETBBOX bbox��ݒ肷��
% 	faceBbox�̏c��20%��
% 	faceBbox�̉���40%��


%% �ݒ�
switch camera
    case 1
        bbox=setBbox1234(faceBboxL);
    case 2
        bbox=setBbox1234(faceBboxR);
    otherwise
        error('error')
end     

%% 	bbox�̊m�F
bbox=checkBbox(bbox,imgSize);

end

