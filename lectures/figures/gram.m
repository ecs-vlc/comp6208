n = 10;
X=randn(n,5);
K = zeros(n,n);
for i = 1:n
  x = X(i,:);
  for j = 1:n
    y = X(j,:);
    K(i,j) = exp(-norm(x-y)^2);
  endfor
endfor

K
eig(K)