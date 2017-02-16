% 絶対誤差と標準偏差を計算し，箱ひげ図をプロットするスクリプト

close all
clear
clc

%% ステレオカメラ
sens=[];
est=[];
stdMat=[];
absdiffMat=[];

for personid=1:8
    for num=1:5
        resultDirName='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\result\30deg\StereoCamera\';
        sensorDirName='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\data\30deg\MotionSensor\';
        saveDirName='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\result\30deg\StereoCamera\';
        
        personName=num2str(personid);
        numName=num2str(num);
        
        resultFileName=[resultDirName,personName,'\',numName,'_yaws.mat'];
        sensorFileName=[sensorDirName,personName,'\',numName,'_sens_yaws.mat'];
        
        load(resultFileName);
        load(sensorFileName);
        
        sens=[sens;sens_yaws];
        est=[est;yaws];
        
        absdiffMat(personid,num)=mean(abs(yaws-sens_yaws));
        stdMat(personid,num)=std(abs(yaws-sens_yaws));
    end
end

error=abs(sens-est);
groupId=zeros(size(error));

groupId(sens<-25)=1;
groupId(-25<=sens&sens<-20)=2;
groupId(-20<=sens&sens<-15)=3;
groupId(-15<=sens&sens<-10)=4;
groupId(-10<=sens&sens<-5)=5;
groupId(-5<=sens&sens<0)=6;
groupId(0<=sens&sens<5)=7;
groupId(5<=sens&sens<10)=8;
groupId(10<=sens&sens<15)=9;
groupId(15<=sens&sens<20)=10;
groupId(20<=sens&sens<25)=11;
groupId(25<=sens)=12;

count(1)=sum(groupId==1);
count(2)=sum(groupId==2);
count(3)=sum(groupId==3);
count(4)=sum(groupId==4);
count(5)=sum(groupId==5);
count(6)=sum(groupId==6);
count(7)=sum(groupId==7);
count(8)=sum(groupId==8);
count(9)=sum(groupId==9);
count(10)=sum(groupId==10);
count(11)=sum(groupId==11);
count(12)=sum(groupId==12);

% 箱ひげ図をプロット
    boxplot(error,groupId)
    xlabel('グループ番号')
    ylabel('絶対誤差 [deg]')
    grid on    
    hold on
    
    % データ数をプロット
yyaxis right
plot(1:12,count,'o')
ax=gca;
ax.YScale='log';
ylabel('データ数 [個] (片対数スケール)')

%% 保存
% savefig([saveDirName,'boxplot'])
% xlswrite([saveDirName,'absdiff'],absdiffMat);
% xlswrite([saveDirName,'std'],stdMat);



%% kinect
sens=[];
est=[];
stdMat=[];
absdiffMat=[];

for personid=1:8
    for num=1:5
        kinectDirName='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\result\30deg\Kinect\';
        sensorDirName='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\data\30deg\MotionSensor\';
        saveDirName='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\result\30deg\Kinect\';
        
        personName=num2str(personid);
        numName=num2str(num);
        
        sensorFileName=[sensorDirName,personName,'\',numName,'_sens_yaws.mat'];
        kinectFileName=[kinectDirName,personName,'\',numName,'_kinect_yaws.mat'];
        
        load(sensorFileName);
        load(kinectFileName);
        
        m=numel(kinect_yaws);        
        kinect_yaws=-kinect_yaws;
        sens_yaws = interp1(1:300,sens_yaws,1:300/m:300)';
        
        sens=[sens;sens_yaws];
        est=[est;yaws];
        
        absdiffMat(personid,num)=nanmean(abs(yaws-sens_yaws));
        stdMat(personid,num)=nanstd(abs(yaws-sens_yaws));
    end
end

error=abs(sens-est);
groupId=zeros(size(error));

groupId(sens<-25)=1;
groupId(-25<=sens&sens<-20)=2;
groupId(-20<=sens&sens<-15)=3;
groupId(-15<=sens&sens<-10)=4;
groupId(-10<=sens&sens<-5)=5;
groupId(-5<=sens&sens<0)=6;
groupId(0<=sens&sens<5)=7;
groupId(5<=sens&sens<10)=8;
groupId(10<=sens&sens<15)=9;
groupId(15<=sens&sens<20)=10;
groupId(20<=sens&sens<25)=11;
groupId(25<=sens)=12;

count(1)=sum(groupId==1);
count(2)=sum(groupId==2);
count(3)=sum(groupId==3);
count(4)=sum(groupId==4);
count(5)=sum(groupId==5);
count(6)=sum(groupId==6);
count(7)=sum(groupId==7);
count(8)=sum(groupId==8);
count(9)=sum(groupId==9);
count(10)=sum(groupId==10);
count(11)=sum(groupId==11);
count(12)=sum(groupId==12);

% 箱ひげ図をプロット
    boxplot(error,groupId)
    xlabel('グループ番号')
    ylabel('絶対誤差 [deg]')
    grid on    
    hold on
    
    % データ数をプロット
yyaxis right
plot(1:12,count,'o')
ax=gca;
ax.YScale='log';
ylabel('データ数 [個] (片対数スケール)')

%% 保存
% savefig([saveDirName,'boxplot'])
% xlswrite([saveDirName,'absdiff'],absdiffMat);
% xlswrite([saveDirName,'std'],stdMat);

