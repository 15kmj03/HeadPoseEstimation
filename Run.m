close all
clear
clc

%�����p���p�x�̕ω��𐄒肷��X�N���v�g

%%
loadFileName='C:\Users\H87-PRO\Desktop\30deg\3\2.mp4';
loadFileNameS='C:\Users\H87-PRO\Desktop\30deg\3\2_sens_betas.mat'
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


