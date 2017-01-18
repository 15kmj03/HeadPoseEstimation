
% close all
% clear
% clc

numfiles=5;

betas=zeros(300,5);
sens_betas=zeros(300,5);

dirName='D:\1226\30deg\katayama\';

for k = 1:numfiles
  myfileName = sprintf('%d_betas.mat', k);
  fileName=[dirName,myfileName];
  temp = importdata(fileName);
  betas(:,k)=temp(1:300);
end

for k = 1:numfiles
  myfileName = sprintf('%d_sens_betas.mat', k);
  fileName=[dirName,myfileName];
  sens_betas(:,k) = importdata(fileName);
end

% time=0.05:0.05:15;
% for k = 1:5
%     subplot(3,2,k)
%     plot(time,betas(:,k),time,sens_betas(:,k),'--');
%     ylim([-30,30]);
%     legend('計測値','センサによる計測値')
%     xlabel('時間 [s]')
%     ylabel('ヨー角度 [deg]');
%     title(sprintf('計測 %d',k))
%     grid on
%     
% end

absdiff=abs(betas-sens_betas);
m=[mean(absdiff),mean(absdiff(:))]
s=[std(absdiff),std(absdiff(:))]

figure
boxplot(absdiff,'Whisker',10);
xlabel('計測番号')
ylabel('絶対誤差 [deg]')
grid on
title('荒井')

% xlswrite('nagaoka_mean',m);
% xlswrite('nagaoka_std',s);

%%%%%%%%%%%%%%%%%
sens_betas=sens_betas(:);
betas=betas(:);
absdiff=absdiff(:);
group=sens_betas;
group(0<=group&group<5)=7;
group(5<=group&group<10)=8;
group(10<=group&group<15)=9;
group(15<=group&group<20)=10;
group(20<=group&group<25)=11;
group(25<=group&group<30)=12;

group(-5<=group&group<0)=6;
group(-10<=group&group<-5)=5;
group(-15<=group&group<-10)=4;
group(-20<=group&group<-15)=3;
group(-25<=group&group<-20)=2;
group(-30<=group&group<-25)=1;

t=table(group,sens_betas,betas,absdiff)

boxplot(absdiff,group)
xlabel('グループ番号')
ylabel('絶対誤差 [deg]')
