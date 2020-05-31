function [d] = distance(Iinp1,Iinp2,Im)
% switch (option)
%     case 1
diff=(Iinp1-Iinp2);
denom = sum(sum(Im>0));
%     d =    sum(sum(((diff).*Im).^2))/(size(Iinp1,1)*size(Iinp1,2));
d =    sum(sum(((diff).*Im).^2))/denom;

% % % % %     d =    sqrt(sum(sum(((diff).*Im).^2)));
%     case 2
%     x=xy(1);y = xy(2);
%     Zp1     =   x-floor(P/2); Zp2  =   x+floor(P/2);
%     Zq1     =   y-floor(Q/2); Zq2  =   y+floor(Q/2); 
%     temp = Im(Zp1:Zp2,Zq1:Zq2);
%     temp1 = Iinp1(Zp1:Zp2,Zq1:Zq2);
%     temp2 = Iinp2(Zp1:Zp2,Zq1:Zq2);
%     d =    sum(sum(((temp1-temp2).*temp).^2));
% end
    