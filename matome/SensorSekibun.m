%%
% �Z���T�[���瓾��ꂽ�f�[�^��ϕ�����X�N���v�g

start=585;


% alphas=alphas(1:300);
yaws=yaws(1:300);
% gammas=gammas(1:300);

GyroXX=GyroX(start:start+1500)-aveGyroX;
GyroYY=GyroY(start:start+1500)-aveGyroY;
GyroZZ=GyroZ(start:start+1500)-aveGyroZ;

% GyroXX=GyroX(start:start+1500);
% GyroYY=GyroY(start:start+1500);
% GyroZZ=GyroZ(start:start+1500);

trapzX=cumtrapz(GyroXX);
trapzY=cumtrapz(GyroYY);
trapzZ=cumtrapz(GyroZZ);
sens_betas=-trapzX*aveAccX*0.01+trapzY*aveAccY*0.01+trapzZ*aveAccZ*0.01;

time=1:300;
sens_betas=sens_betas(1:5:1500);
plot(time,yaws,time,sens_betas)
xlabel('���� [s]')
ylabel('���[�p�x�@[deg]')
grid on
