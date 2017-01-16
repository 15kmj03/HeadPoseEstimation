function [ xyzPoints ] = relocate( xyzPoints, stereoParams )
%RELOCATE ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q

t=stereoParams.TranslationOfCamera2;

xyzPoints=-xyzPoints;
xyzPoints(:,:,1)=xyzPoints(:,:,1)-t(1);
xyzPoints(:,:,2)=xyzPoints(:,:,2)-t(2);
xyzPoints(:,:,3)=xyzPoints(:,:,3)-t(3);
end

