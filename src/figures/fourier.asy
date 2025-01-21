size(150,0);
import graph;

int n = 1;
real cosn(real theta) { return cos(n*theta); }
real sinn(real theta) { return sin(n*theta); }

real y = 0;
for(n=0; n<4; ++n) {
  draw((0,y)--(2pi,y));
  draw((0,y-1.1)--(0,y+1.1));
  draw(shift(0,y)*graph(cosn, 0, 2pi, operator..), blue);
  int l = (n>0)? 2n-1:0;
  label("$b_{"+string(l)+"}(x)$", (0,y), W);
  y -= 2.5;
  if (n>0 && n<3) {
    draw((0,y-1.1)--(0,y+1.1));
    draw((0,y)--(2pi,y));
    draw(shift(0,y)*graph(sinn, 0, 2pi, operator..), blue);
    label("$b_{"+string(2n)+"}(x)$", (0,y), W);
    y -= 2.5;
  }
}
