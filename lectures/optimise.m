function [x,alpha] = optimise(Q,a,r)
  x = rand(5,1);
  alpha = 0;
  for t=1:1000
    x = x - r*(Q*x-alpha*a);
    alpha = alpha + r*(-(a'*x-1));
  endfor
endfunction
