function [ minDisparity ] = determineMinDisparity( grayL,grayR,...
    bboxL,bboxR )
%DETERMINEDISPARITYRANGE ·õÍÍÌÅ¬lðè·é
%
%   [ minDisparity ] = determineMinDisparity( grayL,grayR,bbox )
%
%   input
%   grayL : ¶O[æ
%   grayR : EO[æ
%   bbox : bounding box
%
%   output
%   minDisparity : ·õÍÍÌÅ¬l
%
%                ·õÍÍ[pix]
%      |----------disparityRange----------|
%     min              disp              max
%   disp-32            disp            disp+32
% disparityRangeÍ16Ì{Å éKv è

%% disparityÌvZ

if ~isempty(bboxL)
    disp=calculateDisparity(grayL,grayR,bboxL,1);
else
    if ~isempty(bboxR)
        disp=calculateDisparity(grayL,grayR,bboxR,2);
    else
        minDisparity=nan;
        return
    end    
end

%% minDisparityÌÝè
minDisparity=disp-(8*4);
    
end