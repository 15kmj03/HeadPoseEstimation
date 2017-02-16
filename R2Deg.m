function [ pitch,yaw,roll ] = R2Deg( R )
%R2DEG ‰ñ“]s—ñR‚©‚çŠp“x‚ğZo
%
%   [ alpha,beta,gamma ] = R2Deg( R )
%
%   input
%   R : ‰ñ“]s—ñ
%
%   output
%   pitch : x²‰ñ‚è‚Ì‰ñ“]
%   yaw : y²‰ñ‚è‚Ì‰ñ“]
%   roll : z²‰ñ‚è‚Ì‰ñ“]

%%
pitch=-atan(R(3,2)/R(3,3))/pi*180;
yaw=asin(R(3,1))/pi*180;
roll=-atan(R(2,1)/R(1,1))/pi*180;

end