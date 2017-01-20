close all
clear
clc

groupId12000=[];
absdiff12000=[];

mean8_5=zeros(8,5);
std8_5=zeros(8,5);
for personid=1:8
    yaws300_5=zeros(300,5);
    sensYaws300_5=zeros(300,5);
    groupId=zeros(1500,1);
    
    for num=1:5
        dirName='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\';
        personname=num2str(personid);
        numname=num2str(num);
        
        loadFileNameYaw=[dirName,'result\',personname,'\',numname,'_yaws.mat'];
        loadFileNameSensYaw=[dirName,'data\',personname,'\',numname,'_sens_yaws.mat'];
        
        load(loadFileNameYaw);
        load(loadFileNameSensYaw);
        
        yaws300_5(:,num)=yaws;
        sensYaws300_5(:,num)=sens_betas;
    end
    
    absdiff300_5=abs(yaws300_5-sensYaws300_5);
    mean8_5(personid,:)=mean(absdiff300_5);
    std8_5(personid,:)=std(absdiff300_5);
    
    sensyaws1500=sensYaws300_5(:);
    absdiff1500=absdiff300_5(:);
    
    groupId(sensyaws1500<-25)=1;
    groupId(-25<=sensyaws1500&sensyaws1500<-20)=2;
    groupId(-20<=sensyaws1500&sensyaws1500<-15)=3;
    groupId(-15<=sensyaws1500&sensyaws1500<-10)=4;
    groupId(-10<=sensyaws1500&sensyaws1500<-5)=5;
    groupId(-5<=sensyaws1500&sensyaws1500<0)=6;
    groupId(0<=sensyaws1500&sensyaws1500<5)=7;
    groupId(5<=sensyaws1500&sensyaws1500<10)=8;
    groupId(10<=sensyaws1500&sensyaws1500<15)=9;
    groupId(15<=sensyaws1500&sensyaws1500<20)=10;
    groupId(20<=sensyaws1500&sensyaws1500<25)=11;
    groupId(25<=sensyaws1500)=12;
    
    groupId12000=[groupId12000;groupId];
    absdiff12000=[absdiff12000;absdiff1500];
    
    if sum(groupId==1)==0
        groupId=[groupId;1];
        absdiff1500=[absdiff1500;nan];
    end
    if sum(groupId==2)==0
        groupId=[groupId;2];
        absdiff1500=[absdiff1500;nan];
    end
    if sum(groupId==3)==0
        groupId=[groupId;3];
        absdiff1500=[absdiff1500;nan];
    end
    if sum(groupId==4)==0
        groupId=[groupId;4];
        absdiff1500=[absdiff1500;nan];
    end
    if sum(groupId==5)==0
        groupId=[groupId;5];
        absdiff1500=[absdiff1500;nan];
    end
    if sum(groupId==6)==0
        groupId=[groupId;6];
        absdiff1500=[absdiff1500;nan];
    end
    if sum(groupId==7)==0
        groupId=[groupId;7];
        absdiff1500=[absdiff1500;nan];
    end
    if sum(groupId==8)==0
        groupId=[groupId;8];
        absdiff1500=[absdiff1500;nan];
    end
        if sum(groupId==9)==0
        groupId=[groupId;9];
        absdiff1500=[absdiff1500;nan];
    end
    if sum(groupId==10)==0
        groupId=[groupId;10];
        absdiff1500=[absdiff1500;nan];
    end
    if sum(groupId==11)==0
        groupId=[groupId;11];
        absdiff1500=[absdiff1500;nan];
    end
    if sum(groupId==12)==0
        groupId=[groupId;12];
        absdiff1500=[absdiff1500;nan];
    end
    
    boxplot(absdiff1500,groupId)
    xlabel('グループ番号')
    ylabel('絶対誤差 [deg]')
    grid on
%     savefig([dirName,'result\',personname,'\','hakohige'])
    
    
end

% xlswrite('C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\result\mean8_5',mean8_5);
% xlswrite('C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\result\std8_5',std8_5);

    boxplot(absdiff12000,groupId12000)
    xlabel('グループ番号')
    ylabel('絶対誤差 [deg]')
    grid on
%     savefig([dirName,'result\','hakohige'])