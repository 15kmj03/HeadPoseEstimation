function [ pitch,yaw,roll ] = R2Deg( R )
%R2DEG ��]�s��R����p�x���Z�o
%
%   [ alpha,beta,gamma ] = R2Deg( R )
%
%   input
%   R : ��]�s��
%
%   output
%   pitch : x�����̉�]
%   yaw : y�����̉�]
%   roll : z�����̉�]

%%
pitch=-atan(R(3,2)/R(3,3))/pi*180;
yaw=asin(R(3,1))/pi*180;
roll=-atan(R(2,1)/R(1,1))/pi*180;

end