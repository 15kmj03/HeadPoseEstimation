function [ faceBboxL,faceBboxR ] = checkFaceBbox( faceBboxL,faceBboxR )
%CHECKFACEBBOX faceBbox�̊m�F���s��
%   Y���W�̒��S�ʒu���r���ă`�F�b�N����
%%

th=50;
centerYL=faceBboxL(2)+faceBboxL(4)/2;
centerYR=faceBboxR(2)+faceBboxR(4)/2;

if abs(centerYL-centerYR)>th
    faceBboxL=[];
    faceBboxR=[];
end

end

