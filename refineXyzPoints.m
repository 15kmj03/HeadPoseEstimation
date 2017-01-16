function [ output_args ] = refineXyzPoints( input_args )
%REFINEXYZPOINTS この関数の概要をここに記述
%   詳細説明をここに記述

%%


% xyzPointsをn等分
n=9;
yy=zeros(1,n*2);
h=floor(size(xyzPoints,1)/n)-1;
yy(1)=1;

for i=2:n*2
    if rem(i,2)
        yy(i)=yy(i-1)+1;
    else
        yy(i)=yy(i-1)+h;
    end
end

xyz=cell(n,1);
for i=1:n
    xyz{i}=xyzPoints(yy(i*2-1):yy(i*2),:,:);
end

% 最急降下法でthを決定
for i=1:n
    xval=xyz{i}(:,:,1);
    yval=xyz{i}(:,:,2);
    zval=xyz{i}(:,:,3);
    
    xval=xval(:);
    yval=yval(:);
    zval=zval(:);
    
%     figure(i)
%     plot(xval,zval,'o')
%     grid on
    
    [idx,classCenter] = kmeans(zval,2);
    classCenter=sort(classCenter);
    
    centerX=mean([min(xval),max(xval)]);
    centerZ=mean(classCenter);
    
    xvalA=xval(xval<=centerX);
    yvalA=yval(xval<=centerX);
    zvalA=zval(xval<=centerX);
    
    xvalB=xval(xval>centerX);
    yvalB=yval(xval>centerX);
    zvalB=zval(xval>centerX);
    
    thA=mean(xvalA(centerZ-1<zvalA & zvalA<centerZ+1));
    thB=mean(xvalB(centerZ-1<zvalB & zvalB<centerZ+1));
    
    
    % A
    M=ones(numel(zvalA),1)*classCenter(1);
    M2=M;
    for j=1:100
        M(xvalA<=thA)=classCenter(2);
        M(xvalA>thA)=classCenter(1);
        M2(xvalA<=thA+1)=classCenter(2);
        M2(xvalA>thA+1)=classCenter(1);
        
        fx=sum(abs(M-zvalA));
        fx2=sum(abs(M2-zvalA));
        grad=fx2-fx;
        stepWidth=-0.0001*grad;
        if abs(stepWidth)<0.1
            break
        end
        thB2=thA+stepWidth;
        thA=thB2;
    end
    thA
    
    % B
    M=ones(numel(zvalB),1)*classCenter(1);
    M2=M;
    for j=1:100
        M(xvalB<=thB)=classCenter(1);
        M(xvalB>thB)=classCenter(2);
        M2(xvalB<=thB+1)=classCenter(1);
        M2(xvalB>thB+1)=classCenter(2);
        
        fx=sum(abs(M-zvalB));
        fx2=sum(abs(M2-zvalB));
        grad=fx2-fx;
        stepWidth=-0.0001*grad;
        if abs(stepWidth)<0.1
            break
        end
        thB2=thB+stepWidth;
        thB=thB2;
    end
    thB
    xval=[xvalA(zvalA<centerZ&xvalA>thA);xvalB(zvalB<centerZ&xvalB<thB)];
    yval=[yvalA(zvalA<centerZ&xvalA>thA);yvalB(zvalB<centerZ&xvalB<thB)];
    zval=[zvalA(zvalA<centerZ&xvalA>thA);zvalB(zvalB<centerZ&xvalB<thB)];
    
    xyz{i}=[xval,yval,zval];
    
end

% 合成
xyzPoints=[xyz{1};xyz{2};xyz{3};xyz{4};xyz{5};xyz{6};xyz{7};xyz{8};xyz{9}];

end

