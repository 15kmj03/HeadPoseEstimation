% 自動で全員の推定結果をプロットするスクリプト

close all
clear
clc

%%

for personid=1:8
    for num=1:5
        resultDirName='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\result\30deg\StereoCamera\';
        kinectDirName='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\result\30deg\Kinect\';
        sensorDirName='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\data\30deg\MotionSensor\';        
        saveDirName='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\result\30deg\StereoKinect\';
        
        personName=num2str(personid);
        numName=num2str(num);
        
        resultFileName=[resultDirName,personName,'\',numName,'_yaws.mat'];
        sensorFileName=[sensorDirName,personName,'\',numName,'_sens_yaws.mat'];
        kinectFileName=[kinectDirName,personName,'\',numName,'_kinect_yaws.mat'];
        saveFigFileName=[saveDirName,personName,'\',numName,'_yaw'];
        
        load(resultFileName);
        load(sensorFileName);
        load(kinectFileName);
        
        kinect_yaws=-interp1(1:300/numel(kinect_yaws):300,kinect_yaws,1:300);
                
        x=0:299;
        plot(x,yaws,'-',x,kinect_yaws,'-',x,sens_yaws,'--')
        legend('推定値','kinect','センサ値')
        grid on
        xlabel('時間 [s]')
        ylabel('ヨー角度 [deg]')
        ax=gca;
        ax.XAxisLocation = 'origin';
        ax.XTickLabel=0:2.5:15;
        xlim([0,310])
        
        %% 保存
%         savefig(saveFigFileName)
    end
end