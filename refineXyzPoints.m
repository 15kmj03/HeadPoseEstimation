function [ xyzPoints ] = refineXyzPoints( xyzPoints )
%REFINEXYZPOINTS この関数の概要をここに記述
%   詳細説明をここに記述

n=9;

%% xyzPointsをn等分
nxyz=separateXyzPoints(xyzPoints,n);

%% 最急降下法でthを決定
for i=1:n
    xval=nxyz{i}(:,:,1);
    yval=nxyz{i}(:,:,2);
    zval=nxyz{i}(:,:,3);
        
    temp=[xval(:),yval(:),zval(:)];
    temp=sortrows(temp);
    
    xval=temp(:,1);
    yval=temp(:,2);
    zval=temp(:,3);
    
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
    
    %     thA=mean(xvalA(centerZ-1<zvalA & zvalA<centerZ+1));
    %     thB=mean(xvalB(centerZ-1<zvalB & zvalB<centerZ+1));
    thA=mean([min(xval),centerX]);
    thB=mean([max(xval),centerX]);
    
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
        if isnan(thA)
        end
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
        if isnan(thB)
        end
    end
    thB
    xval=[xvalA(zvalA<centerZ&xvalA>thA);xvalB(zvalB<centerZ&xvalB<thB)];
    yval=[yvalA(zvalA<centerZ&xvalA>thA);yvalB(zvalB<centerZ&xvalB<thB)];
    zval=[zvalA(zvalA<centerZ&xvalA>thA);zvalB(zvalB<centerZ&xvalB<thB)];
    
    nxyz{i}=[xval,yval,zval];
    
    ptCloud=pointCloud(nxyz{i});
    figure(9);
    pcshow(ptCloud, 'VerticalAxis', 'Y', 'VerticalAxisDir', 'Down')
    title('ptCloud');
    
end

%% 合成
xyzPoints=[nxyz{1};nxyz{2};nxyz{3};nxyz{4};nxyz{5};nxyz{6};nxyz{7};nxyz{8};nxyz{9}];

end

