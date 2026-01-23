import myutil;
size(400,0);

label("$|\mat{I}+\epsilon\,\mat{M}|=$", (0,0), W);

draw((0,4.5)--(0,-4.5));
draw((11,4.5)--(11,-4.5));

dot((16,-6), white);
pair pos(int i, int j) {
  return (2i-0.5, 6-2*j);
}

for(int i=1; i<=5; ++i) {
  for(int j=1;  j<=5; ++j) {
    string M = "M_{"+string(i)+string(j)+"}";
    pair p = pos(i,j);
    if (i==j) {
      label("$1+\epsilon\,"+M+"$", p);
    } else {
      label("$\epsilon\,"+M+"$", p);
    }
  }
}

picture bg = new picture;
add(bg, currentpicture);
ship();

picture expansion = new picture;
label(bg, "$=$", (0, -5.5));

for(int i=1; i<=5; ++i) {
  erase();
  string M = "\epsilon\,M_{"+string(i)+"1}";
  if (i%2==1)
    M = "+" + M;
  else
    M = "-" + M;
  if (i==1) {
    M = "(1"+M+")";
  }
  string C = "\,C_{"+string(i)+"1}";
  pair p = (2.8*i, -5.5);
  if (i==1)
    p = p - (0.6,0);
  label(expansion, "$"+M+C+"$", p);
  add(bg);
  add(expansion);
  real s = 1.5;
  if (i==1)
    s = 2.5;
  draw(shift(pos(i,1))*xscale(s)*circle((0,0), 0.5), blue);
  draw(pos(i,2)--pos(i,5), linewidth(20));
  if (i<5)
    draw(pos(i+1,1)--pos(5,1), linewidth(20));
  if (i>1)
    draw(pos(1,1)-(0.5,0)--pos(i-1,1), linewidth(20));
  draw((0.3,3)--(0.3,-4.5), blue);
  draw((10.7,3)--(10.7,-4.5), blue);
  ship();
}

erase();
add(bg);
label("$\,(1+\epsilon\,M_{11})\,C_{11} + O(\epsilon^2)$", (0,-5.5), E);
ship();
erase();
add(bg);
draw(shift(pos(1,1))*xscale(2.5)*circle((0,0), 0.5), blue);
draw(pos(1,2)--pos(1,5), linewidth(20));
draw(pos(2,1)--pos(5,1), linewidth(20));
draw((0.3,3)--(0.3,-4.5), blue);
draw((10.7,3)--(10.7,-4.5), blue);
label("$\,(1+\epsilon\,M_{11})\,C_{11} + O(\epsilon^2)$", (0,-5.5), E);
ship();
erase();
add(bg);
draw(shift(pos(1,1))*xscale(2.5)*circle((0,0), 0.5), blue);
draw(pos(1,2)--pos(1,5), linewidth(20));
draw(pos(2,1)--pos(5,1), linewidth(20));
draw(shift(pos(2,2))*xscale(2.5)*circle((0,0), 0.5), blue);
draw(pos(2,3)--pos(2,5), linewidth(20));
draw(pos(3,2)--pos(5,2), linewidth(20));
draw((4.3,1)--(4.3,-4.5), blue);
draw((10.7,1)--(10.7,-4.5), blue);
label("$\,(1+\epsilon\,M_{11})\,(1+\epsilon\,M_{22})\,C'_{22} + O(\epsilon^2)$", (0,-5.5), E);
ship();
erase();
add(bg);
label("$\prod\limits_i (1+\epsilon\,M_{ii}) + O(\epsilon^2)$", (0,-5.5), E);
ship();
erase();
add(bg);
label("$\,(1+\epsilon \,\sum\limits_i M_{ii}) + O(\epsilon^2)$", (0,-5.5), E);
ship();
erase();
add(bg);
label("$\,(1+\epsilon \,\, \mathrm{tr}\,\, \mat{M}) + O(\epsilon^2)$", (0,-5.5), E);
ship();
erase();
