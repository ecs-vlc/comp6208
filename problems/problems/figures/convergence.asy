import myutil;
size(300,0);

picture ans = new picture;

real x = 0.5;
real xstar = exp(-1);
real s = 0.5;

real diff(real x) {
  return s*log10(abs(x-xstar));
}

pair p = (0, diff(x));
guide g = p;
dot(p, red);
for(int i=1; i<=4; ++i) {
  x = -x*log(x);
  p = (i, diff(x));
  g = g--p;
  dot(ans, p, red);
}

draw((0,-s*17)--(0,0)--(10.5,0),  Arrows);
for(int i=0; i<=10; ++i) {
  draw((i,0)--(i,0.2));
  draw((i,0)--(i,-s*15), dotted+gray);
  label(string(i), (i,0.2), N);
}
for(int i=0; i>=-15; i-=5) {
  draw((0, s*i)--(-0.2, s*i));
  draw((0, s*i)--(10, s*i), dotted+gray);
  string str = "$1$";
  if (i<0) {
    str = "$10^{" + string(i) + "}$";
  }
  label(str, (-0.2, s*i), W);
}

label("iteration, $t$", (10.5,0), E);
label("$\log_{10}\!\left(|x^{(t)}-x^*|\right)$", (0,-s*17), S);

shipout("convergence_q");

add(ans);

draw(g, red);
label("Newton", p, E, red);

real[] rate = {0.5, 0.3, 0.4};

for (int j=0; j<rate.length; ++j) {
  real x = 0.5;
  pair p = (0, diff(x));
  guide g = p;
  dot(p, blue);
  for(int t=1; t<=10; ++t) {
    x = x - rate[j]*(log(x) +1);
    p = (t, diff(x));
    g = g--p;
    dot(p, blue);
  }
  label("$r="+string(rate[j],1)+"$", p, E, blue);
  draw(g, blue+dashed);
  
}

shipout("convergence_a");
