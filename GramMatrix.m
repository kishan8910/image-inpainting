function [val] = GramMatrix(PsiTval,X,n)
I = ones(n,1);
t = reshape(PsiTval,[size(PsiTval,1)*size(PsiTval,2) 1]);
x1 = reshape(X,[size(PsiTval,1)*size(PsiTval,2) n]);
% val = (PsiT*I'-X)'*(PsiT*I'-X);
val = (t*I'-x1)'*(t*I'-x1);