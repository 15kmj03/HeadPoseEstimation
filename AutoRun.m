for personid=3:3
    for num=1:1
        loadDirName='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\data\';
        saveDirName='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\result\';
        personname=num2str(personid);
        numname=num2str(num);
        if personid==7
            suffix='.avi';
        else
            suffix='.mp4';
        end
        
        
        loadFileName=[loadDirName,personname,'\',numname,suffix];
        loadFileNameS=[loadDirName,personname,'\',numname,'_sens_yaws.mat'];
        saveFileNameP=[saveDirName,personname,'\',numname,'_pitches'];
        saveFileNameY=[saveDirName,personname,'\',numname,'_yaws'];
        saveFileNameR=[saveDirName,personname,'\',numname,'_rolls'];
        saveFileNameF=[saveDirName,personname,'\',numname];
        
        [pitches,yaws,rolls]=headPoseEstimation(loadFileName);
        
        
        load(loadFileNameS);
        x=1:300;
        yaws=yaws(1:300);
        figure(1)
        plot(x,yaws,x,sens_betas,'--')
        xlim([0,310])
        ylim([-30,30])
        grid on
        xlabel('時間 [sec]')
        ylabel('ヨー角度 [deg]')
        legend('推定値','センサ値')
        ax = gca;
        ax.XAxisLocation = 'origin';
        ax.XTickLabel = 0:2.5:15;
        
        save(saveFileNameP,'pitches')
        save(saveFileNameY,'yaws')
        save(saveFileNameR,'rolls')
        savefig(saveFileNameF)
    end
end