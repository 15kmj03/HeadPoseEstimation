function [ tform,pitch,yaw,roll ] = checkTform( tform,prevTform )
%CHECKTFORM この関数の概要をここに記述
%   詳細説明をここに記述

R=tform.T(1:3,1:3)';
prevR=prevTform.T(1:3,1:3)';

[pitch,yaw,roll]=R2Deg(R);
[prevPitch,prevYaw,prevRoll]=R2Deg(prevR);

if abs(prevPitch-pitch)>10
    pitch=prevPitch;
    tform=prevTform;
end

if abs(prevYaw-yaw)>10
    yaw=prevYaw;
    tform=prevTform;
end

if abs(prevRoll-roll)>10
    roll=prevRoll;
    tform=prevTform;
end

end

