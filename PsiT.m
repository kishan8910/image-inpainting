function [val] = PsiT(Pbar, Psip,Psipj,W)
% Pbar -> the known pixel.
% Psip -> Patch to be inpainted.
% Psipj -> Patch whose linear combination are chosen for inpainting.
beta = 0.25;
t = Pbar.*Psip;
b1 = WppPsipj(W,Psipj);
b= (sqrt(beta)*(~Pbar)).*b1;
val = [t ; b];