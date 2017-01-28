function [ xyzPoints ] = relocate( xyzPoints, stereoParams )
%RELOCATE 3�������W�����J������ɕύX
%
% [ xyzPoints ] = relocate( xyzPoints, stereoParams )
%
%   input
%   xyzPoints : 3�����������ꂽ���W
%   stereoParams : �J�����p�����[�^
%
%   output
%   xyzPoints : ���J��������Ƃ���3�������W

%%
t=stereoParams.TranslationOfCamera2;

xyzPoints=-xyzPoints;
xyzPoints(:,:,1)=xyzPoints(:,:,1)-t(1);
xyzPoints(:,:,2)=xyzPoints(:,:,2)-t(2);
xyzPoints(:,:,3)=xyzPoints(:,:,3)-t(3);
end

