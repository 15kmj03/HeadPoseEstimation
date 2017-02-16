close all
clear
clc

% 頭部姿勢角度変化を推定する関数を実行するスクリプト


%% 読み込むファイル名の設定
% 動画のファイル名
videoFileName='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\data\30deg\StereoCamera\3\1.mp4';
% センサのファイル名
sensorFileNameS='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\data\30deg\MotionSensor\3\1_sens_yaws.mat';
load(sensorFileNameS);
% kinectのファイル名
kinectFileName='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\result\30deg\Kinect\3\1_kinect_yaws.mat';
load(kinectFileName);

%% 頭部姿勢角度変化推定
[pitches,yaws,rolls,Xs,Ys,Zs]=headPoseEstimation(videoFileName);

%% 結果の表示
kinectDirName='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\resul\30deg\Kinect\';

n=numel(kinect_yaws);
kinect_yaws=-interp1(1:300/n:300,kinect_yaws,1:300);


x=0:299;
plot(x,yaws,'-',x,kinect_yaws,'-.',x,sens_yaws,'--')
legend('推定値','kinect','センサ値')
grid on
xlabel('時間 [s]')
ylabel('ヨー角度 [deg]')
ax=gca;
ax.YAxisLocation = 'origin';
ax.XTickLabel=0:2.5:15;
xlim([0,310])