function [Peeled] = OnionPeel(Image,m,n)
% [x y] = find(Image==0);
% [b1 x1 y1] = unique(y,'first');
% for i=1 : length(x1)
%     Peeled(i,1) =x(x1(i)); Peeled(i,2) = b1(i);
% end
temp = bwperim(~Image);
% figure
% imshow(temp)
% title('temp image :OnionPeeled')
[Peeled(:,1) Peeled(:,2)] = find(temp==1);