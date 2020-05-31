function [val] = Epsilon(DPsiCapp,PsiT)
 val = norm(DPsiCapp-PsiT)^2;