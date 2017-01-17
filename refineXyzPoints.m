function [ xyzPoints ] = refineXyzPoints( xyzPoints )
%REFINEXYZPOINTS この関数の概要をここに記述
%   詳細説明をここに記述

n=5;

%% xyzPointsをn等分
nxyz=separateXyzPoints(xyzPoints,n);

%% ノイズ除去
for i=1:n
    xval=nxyz{i}(:,1);
    yval=nxyz{i}(:,2);
    zval=nxyz{i}(:,3);
    
    th1=min(xval)+(max(xval)-min(xval))*1/3;
    th2=min(xval)+(max(xval)-min(xval))*2/3;
    
    xval1=xval(xval<th1);
    yval1=yval(xval<th1);
    zval1=zval(xval<th1);
    
    xval2=xval(th1<=xval & xval<=th2);
    yval2=yval(th1<=xval & xval<=th2);
    zval2=zval(th1<=xval & xval<=th2);
    
    xval3=xval(th2<xval);
    yval3=yval(th2<xval);
    zval3=zval(th2<xval);
    
    zstd1=std(zval1);
    zstd2=std(zval2);
    zstd3=std(zval3);
    zmean1=mean(zval1);
    zmean2=mean(zval2);
    zmean3=mean(zval3);
    
    newxval=[xval1(abs(zval1-zmean1)<zstd1*2);
        xval2(abs(zval2-zmean2)<zstd2*2);
        xval3(abs(zval3-zmean3)<zstd3*2)];
    newyval=[yval1(abs(zval1-zmean1)<zstd1*2);
        yval2(abs(zval2-zmean2)<zstd2*2);
        yval3(abs(zval3-zmean3)<zstd3*2)];
    newzval=[zval1(abs(zval1-zmean1)<zstd1*2);
        zval2(abs(zval2-zmean2)<zstd2*2);
        zval3(abs(zval3-zmean3)<zstd3*2)];
    
    nxyz{i}=[newxval,newyval,newzval];
end

% ZZ=[nxyz{1}(:,3);nxyz{2}(:,3);nxyz{3}(:,3);nxyz{4}(:,3);nxyz{5}(:,3)];
% [~,ZZZ]=kmeans(ZZ,2);
% ZZZ=sort(ZZZ);

%% 最急降下法でthを決定
for i=1:n

    
    xval=nxyz{i}(:,1);
    yval=nxyz{i}(:,2);
    zval=nxyz{i}(:,3);
    
    %     figure(i)
%         plot(xval,zval,'o')
%         grid on
    
    [~,classCenter] = kmeans(zval,2);
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
%     thA
    
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
%     thB
    newxval=[xvalA(zvalA<classCenter(2)&xvalA>thA);xvalB(zvalB<classCenter(2)&xvalB<thB)];
    newyval=[yvalA(zvalA<classCenter(2)&xvalA>thA);yvalB(zvalB<classCenter(2)&xvalB<thB)];
    newzval=[zvalA(zvalA<classCenter(2)&xvalA>thA);zvalB(zvalB<classCenter(2)&xvalB<thB)];
    
    nxyz{i}=[newxval,newyval,newzval];
    
%     ptCloud=pointCloud(nxyz{i});
%     figure(9);
%     pcshow(ptCloud, 'VerticalAxis', 'Y', 'VerticalAxisDir', 'Down')
%     title('ptCloud');
    
end

%% 合成
xyzPoints=[nxyz{1};nxyz{2};nxyz{3};nxyz{4};nxyz{5}];

end

