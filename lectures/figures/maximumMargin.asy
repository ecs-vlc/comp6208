settings.outformat="pdf";
import myutil;
size(500,0);

pair w= unit((1,2));
pair wc = (w.y,-w.x);
real m = 0.3;

pair[] posData;
pair[] negData;

posData.push(m*w+0.3*wc);
posData.push(m*w-0.5*wc);
negData.push(-m*w+0.1*wc);

real udev() {return rand()/randMax - 0.5;}

for(int i=0; i<20; ++i) {
  pair x = (4*udev(), 2*udev());
  real dp = dot(w,x);
  if (abs(dp)<m)
    continue;
  if (dp>0)
    posData.push(x);
  else
    negData.push(x);
}

void drawData(pair[] data, path p, pen col) {
  for(int i=0; i<data.length; ++i) {
    filldraw(shift(data[i])*p,col,col);
  }
}

real u = 0.03;
drawData(posData, box((-u,-u),(u,u)), blue);
drawData(negData, circle((0,0),u), red);
path bb = box((-2,-1),(2,1));
draw(bb, white);

picture bg = new picture;
add(bg, currentpicture);

ship();

erase();

for(int t=0; t<8; ++t) {
  pair ww;
  real b;
  bool ok = false;
  while (!ok) {
    ww = unit(w+(udev(),udev()));
    b = udev();
    ok = true;
    for(int i=0; i<posData.length; ++i) {
      if (dot(ww,posData[i])<b) {
	  ok = false;
	  break;
      }
    }
    if (ok) {
      for(int i=0; i<negData.length; ++i) {
	if (dot(ww,negData[i])>b) {
	  ok = false;
	  break;
	}
      }
    }
  }
  pair wwc = (ww.y,-ww.x);
  draw((b*ww+3*wwc)--(b*ww-3*wwc));
  clip(currentpicture, bb);
  add(currentpicture, bg);
  ship();
  erase();
}

draw(-3*wc--3*wc);
draw(m*w-3*wc--m*w+3*wc, dashed);
draw(-m*w-3*wc--(-m*w+3*wc), dashed);
draw((0,0)--m*w, dotted, Arrows);
draw(-m*w--(0,0), dotted, Arrows);
label("$\Delta$", 0.5*m*w+0.1*wc);
label("$\Delta$", -0.5*m*w+0.1*wc);
clip(currentpicture, bb);
add(currentpicture, bg);
ship();
