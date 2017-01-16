function [ bbox ] = setBbox( faceBboxL,faceBboxR,camera,imgSize )
%SETBBOX bbox‚ğİ’è‚·‚é
% 	faceBbox‚Ìc•20%Œ¸
% 	faceBbox‚Ì‰¡•40%‘


%% İ’è
switch camera
    case 1
        bbox=setBbox1234(faceBboxL);
    case 2
        bbox=setBbox1234(faceBboxR);
    otherwise
        error('error')
end     

%% 	bbox‚ÌŠm”F
bbox=checkBbox(bbox,imgSize);

end

