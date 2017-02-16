close all
clear
clc

% �����p���p�x�ω��𐄒肷��֐������s����X�N���v�g


%% �ǂݍ��ރt�@�C�����̐ݒ�
% ����̃t�@�C����
videoFileName='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\data\30deg\StereoCamera\3\1.mp4';
% �Z���T�̃t�@�C����
sensorFileNameS='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\data\30deg\MotionSensor\3\1_sens_yaws.mat';
load(sensorFileNameS);
% kinect�̃t�@�C����
kinectFileName='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\result\30deg\Kinect\3\1_kinect_yaws.mat';
load(kinectFileName);

%% �����p���p�x�ω�����
[pitches,yaws,rolls,Xs,Ys,Zs]=headPoseEstimation(videoFileName);

%% ���ʂ̕\��
kinectDirName='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\resul\30deg\Kinect\';

n=numel(kinect_yaws);
kinect_yaws=-interp1(1:300/n:300,kinect_yaws,1:300);


x=0:299;
plot(x,yaws,'-',x,kinect_yaws,'-.',x,sens_yaws,'--')
legend('����l','kinect','�Z���T�l')
grid on
xlabel('���� [s]')
ylabel('���[�p�x [deg]')
ax=gca;
ax.YAxisLocation = 'origin';
ax.XTickLabel=0:2.5:15;
xlim([0,310])