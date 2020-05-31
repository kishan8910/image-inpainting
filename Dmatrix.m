function [D] = Dmatrix(psicapP,Pbar)
% Pbar -> extract known pixel from patch
beta = 0.25;% it is given
   D = [Pbar.*psicapP ; sqrt(beta)*(~Pbar).*psicapP];
   %% FOR CHECKING ONLY
a = (D==NaN);
if (sum(sum(a))>0)
    sum(sum(a))
end