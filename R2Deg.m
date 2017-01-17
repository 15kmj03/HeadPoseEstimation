function [ alpha,beta,gamma ] = R2Deg( R )
%R2DEG ‰ñ“]s—ñR‚©‚çŠp“x‚ğZo
%
%   [ alpha,beta,gamma ] = R2Deg( R )
%
%   input
%   R : ‰ñ“]s—ñ
%
%   output
%   alpha : x²‰ñ‚è‚Ì‰ñ“]
%   beta : y²‰ñ‚è‚Ì‰ñ“]
%   gamma : z²‰ñ‚è‚Ì‰ñ“]

%%
alpha=atan(R(3,2)/R(3,3))/pi*180;
beta=asin(R(3,1))/pi*180;
gamma=atan(R(2,1)/R(1,1))/pi*180;

end
