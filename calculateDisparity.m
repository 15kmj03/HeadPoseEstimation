function [ disparity ] = calculateDisparity( grayL,grayR,bbox,camera )
%CALCULATEDISPARITY bbox領域の視差を計算する
%
%   [ disparity ] = calculateDisparity( grayL,grayR,bbox )
%
%   input
%   grayL : 左グレー画像
%   grayR : 右グレー画像
%   bbox : bounding box
%
%   output
%   disparity : 視差

%%

imgSize=size(grayL);

x=bbox(1);  % x
y=bbox(2);  % y
w=bbox(3);  % width
h=bbox(4);  % height

switch camera
    case 1
        absdiff=zeros(1,x); % 差の総和を保存する為の変数
        
        imgFace=bbox2ROI(grayL,bbox);  % bbox領域を切り出す
        
        for i=1:x
            % ROIの設定
            bboxROI=[i,y,w,h];
            % ROI領域を切り出す
            ROI=bbox2ROI(grayR,bboxROI);
            % 差の総和を計算
            absdiff(i)=sum(sum(imabsdiff(imgFace,ROI)));
        end
        
        [~,I]=min(absdiff); % 最小のインデックスを探す
        
        disparity=abs(x-I);
        
    case 2
        absdiff=zeros(1,imgSize(2)-w); % 差の総和を保存する為の変数
        
        imgFace=bbox2ROI(grayR,bbox);  % bbox領域を切り出す
        
        for i=x:imgSize(2)-w
            % ROIの設定
            bboxROI=[i,y,w,h];
            % ROI領域を切り出す
            ROI=bbox2ROI(grayL,bboxROI);
            % 差の総和を計算
            absdiff(i)=sum(sum(imabsdiff(imgFace,ROI)));
            
        end
        [~,I]=min(absdiff(x:end)); % 最小のインデックスを探す
        I=I+x-1;
        
        disparity=abs(x-I);
end

% figure(1)
% plot(absdiff)
%
% figure
% bbox=[I,y,w,h];
% ROI=bbox2ROI(grayL,bbox);
% imshow(ROI)

end

