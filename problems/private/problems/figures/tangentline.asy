import myutil;
import graph;

size(140,0);

real expm(real x) {
  return exp(-x);
}

draw((0,0)--(0,1.5), Arrow);
label("$f(x)$", (0, 1.5), N);
draw((-0.5,0)--(2,0), Arrow);
label("$x$", (2,0), E);
draw(graph(expm,-0.5,2), red);

draw((1,0)--(1,-0.05));
label("$y$", (1, -0.05), S);

shipout("tangentline_q");

pair p = (1, exp(-1));
dot(p, blue);
draw(p+0.7*(1,-exp(-1))--p+0.7*(-1,exp(-1)), blue);
label("$t(x)$", (0.3, 0.4), blue);
shipout("tangentline_a");
