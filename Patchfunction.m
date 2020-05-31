function [Patch] = Patchfunction(Flag,xy,P,Q,m,n)
for i=1:size(xy,1)
    Patch(:,:,i)=zeros(P,Q);
    if(xy(i,2)-ceil(Q/2)>=0 && xy(i,1)-ceil(P/2)>=0 && xy(i,2)+floor(Q/2)<n && xy(i,1)+floor(P/2)<m   )
        Patch(:,:,i)=Flag((xy(i,1)-floor(P/2)):(xy(i,1)+floor(P/2)),(xy(i,2)-floor(Q/2)):(xy(i,2)+floor(Q/2)));
    elseif(xy(i,1)-ceil(P/2)<0 && xy(i,2)-ceil(Q/2)>0 && xy(i,1)+floor(P/2)<m && xy(i,2)+floor(Q/2)<n   ) %6
        Patch(abs(xy(i,1)-ceil(P/2)+1):P,:,i)=Flag(1:(xy(i,1)+floor(P/2)),(xy(i,2)-floor(Q/2)):(xy(i,2)+floor(Q/2)));
    elseif(xy(i,2)-ceil(Q/2)<0 && xy(i,1)-ceil(P/2)>0 && xy(i,2)+floor(Q/2)<n && xy(i,1)+floor(P/2)<m   ) %5
        Patch(:,abs(xy(i,2)-ceil(Q/2))+1:Q,i)=Flag((xy(i,1)-floor(P/2)):(xy(i,1)+floor(P/2)),1:(xy(i,2)+floor(Q/2)));
    elseif(xy(i,2)-ceil(Q/2)>0 && xy(i,1)-ceil(P/2)>0 && xy(i,2)+floor(Q/2)>n && xy(i,1)+floor(P/2)<m   ) %7
        Patch(:,1:ceil(Q/2)+n-xy(i,2),i)=Flag((xy(i,1)-floor(P/2)):(xy(i,1)+floor(P/2)),(xy(i,2)-floor(Q/2)):n);
    elseif(xy(i,2)-ceil(Q/2)>0 && xy(i,1)-ceil(P/2)>0 && xy(i,2)+floor(Q/2)<n && xy(i,1)+floor(P/2)>m   ) %8
        Patch(1:abs(ceil(P/2)+m-xy(i,1)),:,i)=Flag((xy(i,1)-floor(P/2)):m,(xy(i,2)-floor(Q/2)):(xy(i,2)+floor(Q/2)));        
    elseif xy(i,1)-ceil(P/2)<0 && xy(i,2)-ceil(Q/2)<0 %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~1
        Patch(abs(xy(i,1)-ceil(P/2))+1:P,abs(xy(i,2)-ceil(Q/2))+1:Q,i)=Flag(1:(xy(i,1)+floor(P/2)),1:(xy(i,2)+floor(Q/2)));
    elseif xy(i,1)-ceil(P/2)<0 && xy(i,2)+floor(Q/2)>n  %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~3
        Patch(abs(xy(i,1)-ceil(P/2))+1:P,1:2*floor(Q/2)+(xy(i,2)+floor(Q/2)-n),i)=Flag(1:(xy(i,1)+floor(P/2)),(xy(i,2)-floor(Q/2)):m);
    elseif xy(i,1)+floor(P/2)>m && xy(i,2)-ceil(Q/2)<0  %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~2
        Patch(1:ceil(P/2)+m-xy(i,1),abs(xy(i,2)-ceil(Q/2))+1:Q,i)=Flag((xy(i,1)-floor(P/2)):m,1:(xy(i,2)+floor(Q/2)));
    elseif xy(i,1)+floor(P/2)>m && xy(i,2)+floor(Q/2)>n %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~4
        Patch(1:ceil(P/2)+m-xy(i,1),:,i)=Flag((xy(i,1)-floor(P/2)):m,(xy(i,2)-floor(Q/2)):n); 
    end
end