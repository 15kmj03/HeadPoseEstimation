function [ tform,pitch,yaw,roll ] = checkTform( tform,prevTform )
%CHECKTFORM Tform���m�F����֐�
% �s�b�`�p�C���[�p�C���[���p���}���ɕω����Ă�����1�t���[���O�̌��ʂ𗘗p
%
%   [ tform,pitch,yaw,roll ] = checkTform( tform,prevTform )
%
%   input
%   tform : 2�̓_�Q�̈ʒu���킹���s���A�t�B���ϊ��s��
%   prevTform : �O�t���[���̃A�t�B���ϊ��s��
%
%   output
%   tform : �A�t�B���ϊ��s��
%   pitch : �s�b�`�p
%   yaw : ���[�p
%   roll : ���[���p


R=tform.T(1:3,1:3)';
prevR=prevTform.T(1:3,1:3)';

[pitch,yaw,roll]=R2Deg(R);
[prevPitch,prevYaw,prevRoll]=R2Deg(prevR);

if abs(prevPitch-pitch)>10
    pitch=prevPitch;
    tform=prevTform;
end

if abs(prevYaw-yaw)>10
    yaw=prevYaw;
    tform=prevTform;
end

if abs(prevRoll-roll)>10
    roll=prevRoll;
    tform=prevTform;
end

end