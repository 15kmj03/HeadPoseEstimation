close all
clear
clc

% 頭部姿勢角度変化を推定する関数を実行するスクリプト


%% 読み込むファイル名の設定
% 動画のファイル名
loadFileName='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\data\2\5.mp4';
% センサのファイル名
loadFileNameS='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\data\2\5_sens_yaws.mat';
load(loadFileNameS);

%% 頭部姿勢角度変化推定
[pitches,yaws,rolls]=headPoseEstimation(loadFileName);

%% 結果の表示
x=0:299;
yaws=yaws(1:300);
plot(x,yaws,'-',x,sens_betas,'--')
legend('推定値','センサ値')
grid on
xlabel('時間 [s]')
ylabel('ヨー角度 [deg]')
ax=gca;
ax.YAxisLocation = 'origin';
ax.XTickLabel=0:2.5:15;
xlim([0,310])