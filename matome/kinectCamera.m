for personid=1:8
    
    for num=1:5
        dirStr='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\';
        personStr=num2str(personid);
        numStr=num2str(num);
        
        loadFileNameKinect=[dirStr,'kinect_data\',personStr,'\',numStr,'_kinect_yaws.mat'];
        loadFileNameCamera=[dirStr,'result\',personStr,'\',numStr,'_yaws.mat'];
        loadFileNameSensYaw=[dirStr,'data\',personStr,'\',numStr,'_sens_yaws.mat'];
        saveFileName=[dirStr,'kinect_data\',personStr,'\',numStr,'.fig'];
        saveFileNameEps=[dirStr,'kinect_data\',personStr,'\',personStr,'-',numStr];
        
        load(loadFileNameKinect);
        load(loadFileNameCamera);
        load(loadFileNameSensYaw);
        
        kinect_yaws=[0;kinect_yaws];
        kinect_yaws=kinect_yaws*-1;
        m=numel(kinect_yaws);
        
        yaws=yaws(1:300);
        
        vq = interp1(1:300/m:300,kinect_yaws,1:300);
        plot(1:300,yaws,1:300,vq,'-.',1:300,sens_betas,'--');
        legend('推定値','kinect','センサ値')
        ax = gca;
        xlabel('時間 [s]')
        ylabel('ヨー角度　[deg]')
%         ax.XTick=0:m/6:m;
        ax.XTickLabel=0:2.5:15;
        xlim([0,310])
        
        ax.XAxisLocation='origin';
        grid on
        savefig(saveFileName)
%         print('-painters','-depsc',saveFileNameEps)
    end
end