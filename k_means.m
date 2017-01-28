function [ maeCenter,usiroCenter ] = k_means( zval )
%K_MEANS k-means�@�ɂ��2�̏W���ɕ�����
%
%   [ maeCenter,usiroCenter ] = k_means( zval )

%%
kyoukai=(min(zval)+max(zval))/2;

for i=1:50
    prevKyoukai=kyoukai;
    mae=zval(zval<kyoukai);
    usiro=zval(zval>=kyoukai);
    maeCenter=mean(mae);
    usiroCenter=mean(usiro);
    kyoukai=(maeCenter+usiroCenter)/2;
    if abs(prevKyoukai-kyoukai)<0.5
        break
    end
end

end