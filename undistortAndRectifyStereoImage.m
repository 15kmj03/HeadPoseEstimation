function [ imgL,imgR ] = undistortAndRectifyStereoImage( rawStereoImg,stereoParams )
%UNDISTORTANDRECTIFYSTEREOIMAGE �X�e���I�摜�̘c�ݕ␳�ƕ��s�����s��
% 	L1R2�̃X�e���I�p�����[�^�Řc�ݕ␳
%
%   [ imgL, imgR ] = undistortAndRectifyStereoImage( rawStereoImg, stereoParamsL1R2 )
%
%   input
%   rawStereoImg : �X�e���I�摜
%   stereoParamsL1R2 : �X�e���I�J�����̃L�����u���[�V�����f�[�^
%
%   output
%   imgL : �␳���ꂽ���J�����摜
%   imgR ; �␳���ꂽ�E�J�����摜
%


%% �X�e���I�摜�̘c�ݕ␳�ƕ��s��
% ����
[rawR,rawL] = splitStereoImage(rawStereoImg);

% �c�ݕ␳�ƕ��s��
[imgL,imgR] = rectifyStereoImages(rawL, rawR, stereoParams, 'OutputView', 'valid');

end

