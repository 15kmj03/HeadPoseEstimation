% 自動で全員の頭部姿勢角度変化推定を行うスクリプト


%%

for personid=7:7
    for num=4:4
        videoDirName='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\data\Drive\StereoCamera\';
        resultDirName='C:\Users\exp1\Documents\MATLAB\HeadPoseEstimation\result\Drive\StereoCamera\';
        personname=num2str(personid);
        numname=num2str(num);
        
        
        loadVideoFileName=[videoDirName,personname,'\',numname,'.mp4'];
        savePitchFileName=[resultDirName,personname,'\',numname,'_pitches'];
        saveYawFileName=[resultDirName,personname,'\',numname,'_yaws'];
        saveRollFileName=[resultDirName,personname,'\',numname,'_rolls'];
        saveXFileName=[resultDirName,personname,'\',numname,'_Xs'];
        saveYFileName=[resultDirName,personname,'\',numname,'_Ys'];
        saveZFileName=[resultDirName,personname,'\',numname,'_Zs'];
        
        [pitches,yaws,rolls,Xs,Ys,Zs]=headPoseEstimation(loadVideoFileName);
        
        %% 保存
%         save(savePitchFileName,'pitches')
%         save(saveYawFileName,'yaws')
%         save(saveRollFileName,'rolls')
%         save(saveXFileName,'Xs')
%         save(saveYFileName,'Ys')
%         save(saveZFileName,'Zs')

    end
end