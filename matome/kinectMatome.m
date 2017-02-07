a=[];
b=[];

mean8_5=zeros(8,5);
std8_5=zeros(8,5);

for personid=1:8
    
    for num=1:5
        dirStr='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\';
        personStr=num2str(personid);
        numStr=num2str(num);
        
        loadFileNameKinect=[dirStr,'kinect_data\',personStr,'\',numStr,'_kinect_yaws.mat'];
        loadFileNameSensYaw=[dirStr,'data\',personStr,'\',numStr,'_sens_yaws.mat'];
        saveFileName=[dirStr,'kinect_data\',personStr,'\',numStr,'.fig'];
        
        load(loadFileNameKinect);
        load(loadFileNameSensYaw);
        
        kinect_yaws=[0;kinect_yaws];
        kinect_yaws=kinect_yaws*-1;
        m=numel(kinect_yaws);
        
        vq = interp1(1:300,sens_betas,1:300/m:300);
        plot(1:numel(vq),kinect_yaws,1:m,vq,'--');
        legend('推定値','センサ値')
        ax = gca;
        xlabel('時間 [s]')
        ylabel('ヨー角度　[deg]')
        ax.XTick=0:m/6:m;
        ax.XTickLabel=0:2.5:15;
        xlim([1,m+2.5])
        
        ax.XAxisLocation='origin';
        grid on
        savefig(saveFileName)
        absdiff=abs(vq(:)-(kinect_yaws));
        
        mean8_5(personid,num)=mean(absdiff(:));
        std8_5(personid,num)=std(absdiff(:));
        
        a=[a;absdiff];
        b=[b;vq(:)];
    end
end

groupId=zeros(numel(a),1);

groupId(b<-25)=1;
    groupId(-25<=b&b<-20)=2;
    groupId(-20<=b&b<-15)=3;
    groupId(-15<=b&b<-10)=4;
    groupId(-10<=b&b<-5)=5;
    groupId(-5<=b&b<0)=6;
    groupId(0<=b&b<5)=7;
    groupId(5<=b&b<10)=8;
    groupId(10<=b&b<15)=9;
    groupId(15<=b&b<20)=10;
    groupId(20<=b&b<25)=11;
    groupId(25<=b)=12;

    
%     if sum(groupId==1)==0
%         groupId=[groupId;1];
%         absdiff1500=[absdiff1500;nan];
%     end
%     if sum(groupId==2)==0
%         groupId=[groupId;2];
%         absdiff1500=[absdiff1500;nan];
%     end
%     if sum(groupId==3)==0
%         groupId=[groupId;3];
%         absdiff1500=[absdiff1500;nan];
%     end
%     if sum(groupId==4)==0
%         groupId=[groupId;4];
%         absdiff1500=[absdiff1500;nan];
%     end
%     if sum(groupId==5)==0
%         groupId=[groupId;5];
%         absdiff1500=[absdiff1500;nan];
%     end
%     if sum(groupId==6)==0
%         groupId=[groupId;6];
%         absdiff1500=[absdiff1500;nan];
%     end
%     if sum(groupId==7)==0
%         groupId=[groupId;7];
%         absdiff1500=[absdiff1500;nan];
%     end
%     if sum(groupId==8)==0
%         groupId=[groupId;8];
%         absdiff1500=[absdiff1500;nan];
%     end
% cx        if sum(groupId==9)==0
%         groupId=[groupId;9];
%         absdiff1500=[absdiff1500;nan];
%     end
%     if sum(groupId==10)==0
%         groupId=[groupId;10];
%         absdiff1500=[absdiff1500;nan];
%     end
%     if sum(groupId==11)==0
%         groupId=[groupId;11];
%         absdiff1500=[absdiff1500;nan];
%     end
%     if sum(groupId==12)==0
%         groupId=[groupId;12];
%         absdiff1500=[absdiff1500;nan];
%     end
    
    boxplot(a,groupId)
    xlabel('グループ番号')
    ylabel('絶対誤差 [deg]')
    grid on