settings.outformat="pdf";
import myutil;
import palette;
import graph;
import contour;

size(400,0);

real f(pair p)
{
  return 0.5*p.x*p.x + p.y*p.y - p.x*p.y;
}


real g(real x, real y)
{
  return 1-f((x,y));
}

pair ll = (-2.2,-1.2);
pair ur = (2.2,1.2);
path bb = box(ll, ur);

real c[] = new real[12];
for(int i=0; i<c.length; ++i) {
  c[i] = 0.5*(1+i);
}

pen[] p=sequence(new pen(int i) {
return (c[i] >= 0 ? solid : dashed)+fontsize(6pt);
},c.length);

Label[] Labels=sequence(new Label(int i) {
return Label(c[i] != 0.0 ? (string) c[i] :"",Relative(unitrand()),(0,0),
	     UnFill(1bp));
},c.length);

image(g,ll, ur,BWRainbow());
//draw(contour(f, ll, ur, c));
draw(Labels,contour(f,ll,ur,c),p);

draw((-2.2,0)--(2.2,0), Arrow);
draw((0,-1.2)--(0,1.2), Arrow);
label("$w_2$", (2.2,0), E);
label("$w_1$", (0,1.2), N);
for(int i=-2; i<=2; ++i) {
  draw((i,0)--(i,-0.1));
  label(string(i), (i,-0.05), S);
}
for(int i=-1; i<=1; ++i) {
  draw((0,i)--(-0.05,i));
  label(string(i), (-0.05,i), W);
}


