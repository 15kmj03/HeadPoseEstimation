function [ tform,pitch,yaw,roll ] = checkTform( tform,prevTform )
%CHECKTFORM Tformを確認する関数
% ピッチ角，ヨー角，ロール角が急激に変化していたら1フレーム前の結果を利用
%
%   [ tform,pitch,yaw,roll ] = checkTform( tform,prevTform )
%
%   input
%   tform : 2つの点群の位置合わせを行うアフィン変換行列
%   prevTform : 前フレームのアフィン変換行列
%
%   output
%   tform : アフィン変換行列
%   pitch : ピッチ角
%   yaw : ヨー角
%   roll : ロール角


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