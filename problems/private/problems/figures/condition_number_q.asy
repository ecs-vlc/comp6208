import myutil;
size(350,0);

draw((0, 4.5)--(0,0)--(10.5,0), Arrows);

for(int i=0; i<=4; ++i) {
  draw((0,i)--(-0.2,i));
  label("$10^{" + string(i) + "}$",(-0.2,i), W);
  if (i==4)
    break;
  for(int j=1; j<9; ++j) {
    real y = i + log10(j);
    draw((0,y)--(-0.1,y));
  }
}

for(int i=0; i<=10; ++i)  {
  if (i%2==0) {
    draw((i,0)--(i,-0.2));
    label(string(i), (i,-0.2), S);
  } else
    draw((i,0)--(i,-0.1));
}

label("$\mathbb{E}\!\left[\frac{s_{max}}{s_{min}}\right]$", (-1,2.25), W);
label("$\displaystyle \frac{m}{p}$", (10.5,0), E);
