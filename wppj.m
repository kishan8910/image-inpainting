function [w] = wppj(d)
   temp = exp(-(d./25));%sism^2 = 5
%    s= sum(temp.^2); Previously
s= sum(temp);
   w = temp./s;