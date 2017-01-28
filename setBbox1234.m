function [ bbox ] = setBbox1234( faceBbox )
%SETBBOX1234 3ŸŒ³•œŒ³‚Ì‘ÎÛ‚Æ‚È‚ébbox‚ğİ’è‚·‚é

%%
bbox=zeros(1,4);

bbox(1)=faceBbox(1)-round(faceBbox(3)*0.2);
bbox(2)=faceBbox(2)+round(faceBbox(4)*0.2);
bbox(3)=round(faceBbox(3)*1.4);
bbox(4)=round(faceBbox(4)*0.8);

end