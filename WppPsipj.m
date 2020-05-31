function [Sum] = WppPsipj(W,Psipj)
% W -> Wppj in the journal.
% Psipj -> Patch whose linear combination are chosen for inpainting. 
l = length(W);
Sum = zeros(size(Psipj(:,:,1)));
for i = 1 : l
    Sum = Sum+W(i).*Psipj(:,:,i);
end