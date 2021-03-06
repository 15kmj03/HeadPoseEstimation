function [ disparity ] = calculateDisparity( grayL,grayR,bbox,camera )
%CALCULATEDISPARITY bboxΜζΜ·πvZ·ι
%
%   [ disparity ] = calculateDisparity( grayL,grayR,bbox )
%
%   input
%   grayL : ΆO[ζ
%   grayR : EO[ζ
%   bbox : bounding box
%
%   output
%   disparity : ·

%%

imgSize=size(grayL);

x=bbox(1);  % x
y=bbox(2);  % y
w=bbox(3);  % width
h=bbox(4);  % height

switch camera
    case 1
        absdiff=zeros(1,x); % ·ΜaπΫΆ·ιΧΜΟ
        
        imgFace=bbox2ROI(grayL,bbox);  % bboxΜζπΨθo·
        
        for i=1:x
            % ROIΜέθ
            bboxROI=[i,y,w,h];
            % ROIΜζπΨθo·
            ROI=bbox2ROI(grayR,bboxROI);
            % ·ΜaπvZ
            absdiff(i)=sum(sum(imabsdiff(imgFace,ROI)));
        end
        
        [~,I]=min(absdiff); % Ε¬ΜCfbNXπT·
        
        disparity=abs(x-I);
        
    case 2
        absdiff=zeros(1,imgSize(2)-w); % ·ΜaπΫΆ·ιΧΜΟ
        
        imgFace=bbox2ROI(grayR,bbox);  % bboxΜζπΨθo·
        
        for i=x:imgSize(2)-w
            % ROIΜέθ
            bboxROI=[i,y,w,h];
            % ROIΜζπΨθo·
            ROI=bbox2ROI(grayL,bboxROI);
            % ·ΜaπvZ
            absdiff(i)=sum(sum(imabsdiff(imgFace,ROI)));
            
        end
        [~,I]=min(absdiff(x:end)); % Ε¬ΜCfbNXπT·
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

