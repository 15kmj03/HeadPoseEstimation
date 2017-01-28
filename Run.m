close all
clear
clc

%頭部姿勢角度の変化を推定するスクリプト

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
xlabel('時間 [s]')
ylabel('ヨー角度 [deg]')


