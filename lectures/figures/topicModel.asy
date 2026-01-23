settings.outformat="pdf";
size(400,0);

void drawDoc(pair pos, string str) {
  path p = (0,0)--(0,1)--(0.6,1)--(0.6,0.15)--(0.45,0.15)--(0.45,0)--cycle;
  draw(shift(pos)*p);
  draw(pos+(0.45,0)--pos+(0.6,0.15));
  for(real y=0.1; y<0.99; y+=0.1) {
    real x = 0.1;
    while (x<0.5) {
      real xp = x + 0.02 + 0.03*rand()/randMax;
      if (y<0.15 && xp>0.45) {
	xp = 0.44;
      }
      draw(pos+(x,y)--pos+(xp,y), linewidth(3)+gray);
      x = xp + 0.03;
      if (y<0.15 && x>0.44) {
	break;
      }
    }
  }
  label(str, pos+(0.3,1), N);
}

for(real i=0; i<3; i+=1) {
  drawDoc((i,0), "$d_" + string(i+1) + "$");
}

for(real i=3; i<3.7; i+=0.3)
  filldraw(circle((i,0.5), 0.03));

drawDoc((4,0), "$d_{|\mathcal{C}|}$");


void drawTopic(pair pos, string str) {
  filldraw(shift(pos)*xscale(2.1)*yscale(1.1)*circle((0,0), 0.2), white, white);
  draw(shift(pos)*xscale(2)*circle((0,0), 0.2));
  label("Topic " + str, pos);
}

pair tp[] = {(0.5, -1), (1.7, -1), (4, -1)};

pair[] doc = {(0.3,-0.08),(1.3,-0.08),(2.3,-0.08),(4.3,-0.08)};

void connect1(int d, int t, real w, pair D) {
  pair v = tp[t]-doc[d];
  pair v0 = -v*(0.05/v.y);
  pair v1 = -v*(0.7/v.y);
  draw(doc[d]+v0--doc[d]+v1,  linewidth(w), Arrow(10));
  pair v2 = -v*(0.3/v.y);
  string dstr = (d<3)? string(d+1):"|\mathcal{C}|";
  string tstr = (t<2)? string(t+1):"|\mathcal{T}|";
  label("\small $\theta^{(d_{"+dstr+"})}_{t_{"+tstr+"}}$", doc[d]+v2, red, UnFill);
}
connect1(0,0,3,1.3W);
connect1(0,1,2,1.9E);
connect1(1,0,1,1.5W);
connect1(1,1,4,1.5E);
connect1(2,1,5,1.5W);
connect1(3,1,1,4.5W);
connect1(3,2,4,1.5E);


for(int x=1; x<3; x+=1) {
  drawTopic(tp[x-1], "$t_" + string(x) + "$");
}

for(real i=2.6; i<3.2; i+=0.3)
  filldraw(circle((i,-1), 0.03));


drawTopic(tp[2], "$t_{|\mathcal{T}|}$");

shipout("topicModelWtoT");

erase();

label("\Huge $\mathcal{V} = \left\{w_1,\,w_2,\,w_3,\,\ldots,\, w_{|\mathcal{V}|}\right\}$", (2,0), N);
/*
draw(tp[0]--(1.2,0), linewidth(4), Arrow(10));
draw(tp[1]--(1.25,0), linewidth(1), Arrow(10));
draw(tp[0]--(1.55,0), linewidth(2), Arrow(10));
draw(tp[1]--(1.63,0), linewidth(3), Arrow(10));
draw(tp[1]--(2.1,0), linewidth(5), Arrow(10));
draw(tp[1]--(3.08,0), linewidth(4), Arrow(10));
draw(tp[2]--(3.12,0), linewidth(1), Arrow(10));
*/

pair[] wp = {(1.2,0.1),(1.6,0.1),(2.1,0.1),(3.1,0.1)};

void connect(int t, int w, real p, pair D=(0,0)) {
  pair v = wp[w]-tp[t];
  pair v1 = -v*(0.05/v.y);
  draw(tp[t]--wp[w]+v1,  linewidth(p), Arrow(10));
  pair v2 = -v*(0.7/v.y);
  string wstr = (w<3)? string(w+1):"|\mathcal{V}|";
  string tstr = (t<2)? string(t+1):"|\mathcal{T}|";
  label("\small $\phi_{w_{"+wstr+"}}^{(t_{"+tstr+"})}$", wp[w]+v2, D, red, UnFill);
}

connect(0,0,4,0.1W);
connect(0,1,1,0.1E);
connect(1,0,1);
connect(1,2,3);
connect(1,3,2);
connect(2,3,4);




for(int x=1; x<3; x+=1) {
  drawTopic(tp[x-1], "$t_" + string(x) + "$");
}

drawTopic(tp[2], "$t_{|\mathcal{T}|}$");
for(real i=2.6; i<3.2; i+=0.3)
  filldraw(circle((i,-1), 0.03));

shipout("topicModel");
