function [rho] = SimilarityMeasure(Pn,Qn,Patch, NPatch,Im)
% Patch -> Patch at point P.
% NPatch -> neighbouring  patch.
% Im -> Image mask corresponding to the selected patch.
% for j = 1 : size(NPatch,3)
Ns  = size(NPatch,3);
N = Pn * Qn;
    for i = 1 : Ns
        d(i) = distance(Patch,NPatch(:,:,i),Im);
    end
    w = wppj(d);
%     clear d;
    rho = sqrt(sum(w)*(Ns/N));
% end