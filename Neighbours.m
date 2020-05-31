function [NeighCell] = Neighbours(P,Q,m,n,xy,Flag)
        for i=1:size(xy,1)
            clear Neigh_xy;
                Zp1     =   xy(i,1)-floor(P/2); Zp2  =   xy(i,1)+floor(P/2);
                Zq1     =   xy(i,2)-floor(Q/2); Zq2  =   xy(i,2)+floor(Q/2);
                if Zp1 <1; Zp1 =1; end
                if Zp2 >m; Zp2 =m; end
                if Zq1 <1; Zq1 =1; end
                if Zq2  >n; Zq2 =n; end
                count=0;
                        for l=Zp1 : Zp2
                            for j= Zq1:Zq2
                                if l==xy(i,1) && j==xy(i,2) ||Flag(l,j)==0
                                else
                                    count=count+1;
                                    Neigh_xy(count,1) =l;   Neigh_xy(count,2)=j; 
                                end
                            end
                        end                
                    NeighCell{i}=Neigh_xy;
        end
end
    