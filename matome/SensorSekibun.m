%%
% �Z���T�[���瓾��ꂽ�f�[�^��ϕ�����X�N���v�g
% �X�N���v�g���s����O�ɃZ���T�[�f�[�^�����[�h����K�v����

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
xlabel('���� [s]')
ylabel('���[�p�x�@[deg]')
grid on
