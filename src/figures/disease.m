r0 = 2.5;
r = r0/3;
p = 0.1;
T = 30;
Z = zeros(T,1);
X = zeros(T,1);
Z(1) = 1;
Z(2) = poissrnd(r*Z(1));
Z(3) = poissrnd(r*(Z(1)+Z(2)));
for t = 4:T
   Z(t) = poissrnd(r*(Z(t-1)+Z(t-2)+Z(t-3)));
endfor

s="";
for t= 1:T
  X(t) = binornd(Z(t),p);
endfor

X'
