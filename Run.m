close all
clear
clc

% �����p���p�x�ω��𐄒肷��֐������s����X�N���v�g


%% �ǂݍ��ރt�@�C�����̐ݒ�
% ����̃t�@�C����
loadFileName='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\data\2\5.mp4';
% �Z���T�̃t�@�C����
loadFileNameS='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\data\2\5_sens_yaws.mat';
load(loadFileNameS);

%% �����p���p�x�ω�����
[pitches,yaws,rolls]=headPoseEstimation(loadFileName);

%% ���ʂ̕\��
x=0:299;
yaws=yaws(1:300);
plot(x,yaws,'-',x,sens_betas,'--')
legend('����l','�Z���T�l')
grid on
xlabel('���� [s]')
ylabel('���[�p�x [deg]')
ax=gca;
ax.YAxisLocation = 'origin';
ax.XTickLabel=0:2.5:15;
xlim([0,310])