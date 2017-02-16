%%
% センサーから得られたデータを積分するスクリプト
% スクリプト実行する前にセンサーデータをロードする必要あり

start=1950;

GyroXX=GyroX(start:start+1500)-biasGyroX;
GyroYY=GyroY(start:start+1500)-biasGyroY;
GyroZZ=GyroZ(start:start+1500)-biasGyroZ;
trapzX=cumtrapz(GyroXX);
trapzY=cumtrapz(GyroYY);
trapzZ=cumtrapz(GyroZZ);

sens_betas=-trapzX*aveAccX*0.01+trapzY*aveAccY*0.01+trapzZ*aveAccZ*0.01;

time=0:299;
sens_betas=sens_betas(1:5:1500);
plot(time,kinect_yaws,time,sens_betas)
xlabel('時間 [s]')
ylabel('ヨー角度　[deg]')
grid on
