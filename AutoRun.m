for personid=1:8
    for num=1:5
        if personid==3&&num==3
            continue
        end
        if personid==8&&num==3
            continue
        end
        loadDirName='C:\Users\H87-PRO\Desktop\30deg\';
        saveDirName='C:\Users\H87-PRO\Desktop\result\';
        personname=num2str(personid);
        numname=num2str(num);
        if personid==7
            suffix='.avi';
        else
            suffix='.mp4';
        end
        
        
        loadFileName=[loadDirName,personname,'\',numname,suffix];
        loadFileNameS=[loadDirName,personname,'\',numname,'_sens_betas.mat'];
        saveFileNameP=[saveDirName,personname,'\',numname,'_pitches'];
        saveFileNameY=[saveDirName,personname,'\',numname,'_yaws'];
        saveFileNameR=[saveDirName,personname,'\',numname,'_rolls'];
        saveFileNameF=[saveDirName,personname,'\',numname];
        
        [pitches,yaws,rolls]=headPoseEstimation(loadFileName);
        
        
        load(loadFileNameS);
        x=1:300;
        yaws=yaws(1:300);
        figure(1)
        plot(x,yaws,x,sens_betas)
        ylim([-30,30])
        grid on
        xlabel('éûä‘ [s]')
        ylabel('ÉàÅ[äpìx [deg]')
        
        
        
        save(saveFileNameP,'pitches')
        save(saveFileNameY,'yaws')
        save(saveFileNameR,'rolls')
        savefig(saveFileNameF)
    end
end