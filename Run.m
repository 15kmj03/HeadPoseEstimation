close all
clear
clc

%�����p���p�x�̕ω��𐄒肷��X�N���v�g

%%
loadFileName='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\data\3\2.mp4';
% loadFileName='D:\1226\drive\arai\1.mp4';
loadFileNameS='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\data\3\2_sens_yaws.mat';
load(loadFileNameS);

[pitches,yaws,rolls]=headPoseEstimation(loadFileName);

x=1:300;
yaws=yaws(1:300);
figure(1)
plot(x,yaws,x,sens_betas)
ylim([-30,30])
grid on
xlabel('���� [s]')
ylabel('���[�p�x [deg]')


