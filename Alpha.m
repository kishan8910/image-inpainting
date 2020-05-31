function [val] = Alpha(G,n)
I = ones(n,1);
temp = inv(G);
if (sum(sum(isinf(temp))) > 0)
    val = (pinv(G)*I)/(I'*pinv(G)*I);
else
    val = (temp*I)/(I'*temp*I);
end
% put a condition and put pinv (pueudo inverse) instead of inv