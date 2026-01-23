import graph;
import stats;
import myutil;
import sos;

size(400,200,IgnoreAspect);

int n1=500;
int n2=200;
real[] a=new real[n1+n2];
for(int i=0; i<n1; ++i) {
  a[i]=Gaussrand();
}
for(int i=n1; i<n1+n2; ++i) {
  a[i]=Gaussrand()+3;
}

histogram(a,min(a),max(a),40,normalize=true,low=0,lightred,black,bars=false);

xaxis("$x$",BottomTop,LeftTicks);
yaxis("$f(x)$",LeftRight,RightTicks(trailingzero));

ship();

struct Theta {
  real p1;
  real mu1;
  real var1;
  real p2;
  real mu2;
  real var2;
  static Theta Theta(real p1in, real mu1in, real var1in, real mu2in, real var2in) {
    Theta theta = new Theta;
    theta.p1 = p1in;
    theta.mu1 = mu1in;
    theta.var1 = var1in;
    theta.p2 = 1-p1in;
    theta.mu2 = mu2in;
    theta.var2 = var2in;
    return theta;
  }
}

from Theta unravel Theta;


real normal(real x, real mu, real var) {
  return exp(-0.5*(x-mu)*(x-mu)/var)/sqrt(2*pi*var);
}

Theta theta = Theta(0.5,-1,1.2,2,0.8);
//theta = Theta(0.7,0,1,3,1);

picture paramPic = new picture;

pair[] mv1;
pair[] mv2;
pair[] pp;
mv1.push((theta.mu1, theta.var1));
mv2.push((theta.mu2, theta.var2));
pp.push((theta.p1, theta.p2));



for(int t=1; t<100; ++t) {
  //  write(theta.p1, theta.mu1, theta.var1, theta.mu2, theta.var2);
  Theta tp = Theta(0,0,0,0,0);
  for(int i=0; i<a.length; ++i) {
    real pj1 = normal(a[i], theta.mu1, theta.var1)*theta.p1;
    real pj2 = normal(a[i], theta.mu2, theta.var2)*theta.p2;
    real p1 = pj1/(pj1+pj2);
    real p2 = pj2/(pj1+pj2);
    tp.p1 += p1;
    tp.mu1 += p1*a[i];
    tp.mu2 += p2*a[i];
  }
  tp.mu1 /= tp.p1;
  tp.mu2 /= a.length-tp.p1;
  for(int i=0; i<a.length; ++i) {
    real pj1 = normal(a[i], theta.mu1, theta.var1)*theta.p1;
    real pj2 = normal(a[i], theta.mu2, theta.var2)*theta.p2;
    real p1 = pj1/(pj1+pj2);
    real p2 = pj2/(pj1+pj2);
    tp.var1 += p1*(a[i]-tp.mu1)*(a[i]-tp.mu1);
    tp.var2 += p2*(a[i]-tp.mu2)*(a[i]-tp.mu2);
  }
  tp.var1 /= tp.p1;
  tp.var2 /= a.length-tp.p1;
  tp.p1 /= a.length;
  tp.p2 = 1 - tp.p1;
  //  write(tp.p1, tp.mu1, tp.var1, tp.mu2, tp.var2);
  theta = Theta(tp.p1, tp.mu1, tp.var1, tp.mu2, tp.var2);
  mv1.push((theta.mu1, sqrt(theta.var1)));
  mv2.push((theta.mu2, sqrt(theta.var2)));
  pp.push((theta.p1, theta.p2));
}

real mu = theta.mu1;
real var = theta.var1;
real p = theta.p1;

real Gaussian(real x) {return p*normal(x, mu, var);}
real mixture(real x) {
  return theta.p1*normal(x, theta.mu1, theta.var1)
    + theta.p2*normal(x, theta.mu2, theta.var2);
}

draw(graph(Gaussian,min(a),max(a)),blue);
mu = theta.mu2;
var = theta.var2;
p = theta.p2;

draw(graph(Gaussian,min(a),max(a)),blue);
draw(graph(mixture,min(a),max(a)),heavygreen+dashed+linewidth(2));
ship();

erase();
size(400,0);

void cross(pair p, real d=0.06, pen col=blue) {
  draw(p+(d,d)--p+(-d,-d), col);
  draw(p+(d,-d)--p+(-d,d), col);
}

void cross(real x, real y, real d=0.6, pen col=blue) {
  cross((x,y),d,col);
}

draw((-1.5,0)--(4.5,0), Arrow);
draw((0,0)--(0,1.4), Arrow);
for(int i=-1; i<=4; ++i) {
  draw((i,0)--(i,-0.05));
  label(string(i), (i,-0.05), S);
}
draw((0,1)--(-0.05,1));
label("1.0", (-0.05,1), W);
draw((0,0.5)--(-0.05,0.5));
label("0.5", (-0.05,0.5), W);
label("$\sigma$", (0,1.4), N);
label("$\mu$", (4.5,0), E);

pair sh = (5.5,0);

guide g1, g2;
dot(mv1[0]);
dot(mv2[0]);
dot(sh+pp[0]);
for(int t=1; t<mv1.length; ++t) {
  dot(mv1[t]);
  dot(mv2[t]);
  draw(mv1[t-1]--mv1[t]);
  draw(mv2[t-1]--mv2[t]);
  dot(sh+pp[t]);
  draw(sh+pp[t-1]--sh+pp[t]);
}

int last = mv1.length-1;
label("$(\mu_1^{(\infty)},\sigma_1^{(\infty)})$", mv1[last], E);
label("$(\mu_2^{(\infty)},\sigma_2^{(\infty)})$", mv2[last], NE);
label("$(\mu_1^{(1)},\sigma_1^{(1)})$", mv1[0],N);
label("$(\mu_2^{(1)},\sigma_2^{(1)})$", mv2[0],S);
label("$(p_1^{(1)},p_2^{(1)})$", sh+pp[0]+(0.08,0),N);
label("$(p_1^{(\infty)},p_2^{(\infty)})$", sh+pp[last], E);

cross((0,1));
cross((3,1));
cross(sh+(5/7,2/7));
      
draw(sh+(0,1.4)--sh+(0,0)--sh+(1.4,0), Arrows);
for(real i=0; i<3; ++i) {
  draw(sh+(i/2,0)--sh+(i/2,-0.05));
  label(string(i/2,2), sh+(i/2,-0.05), S);
  draw(sh+(0,i/2)--sh+(-0.05,i/2));
  label(string(i/2,2), sh+(-0.05,i/2), W);
}
label("$p_1$", sh+(1.4,0), E);
label("$p_2$", sh+(0,1.4), N);

ship();

real mu1 = -1;
real mu2 = 2;
real sigma1 = 1.2;
real sigma2 = 0.8;
real p1 = 0.5;


real logLikelihood(real[] data, real mu1, real sigma1,
		   real mu2, real sigma2, real p1) {
  real ll = 0;
  for(int i=0; i<data.length; ++i) {
    ll += log(p1*normal(data[i],mu1,sigma1*sigma1)
	      + (1.0-p1)*normal(data[i],mu2,sigma2*sigma2));
  }
  return ll;
}
      

int T = 100000;
int burnin = 100;
Sos mu1post = Sos();
Sos sigma1post = Sos();
Sos mu2post = Sos();
Sos sigma2post = Sos();
Sos p1post = Sos();
real ll = logLikelihood(a, mu1, sigma1, mu2, sigma2, p1);
for(int t=0; t<T+burnin; ++t) {
  real mu1p = mu1 + 0.1*Gaussrand();
  real sigma1p = abs(sigma1+0.1*Gaussrand());
  real mu2p = mu2 + 0.1*Gaussrand();
  real sigma2p = abs(sigma1+0.1*Gaussrand());
  real p1p = abs(p1 + 0.1*Gaussrand());
  if (p1p>1)
    p1p -= 1.0;
  real llp = logLikelihood(a, mu1p, sigma1p, mu2p, sigma2p, p1p);
  real r =  (sigma1*sigma2)*exp(llp-ll)/(sigma1p*sigma2p);
  //  write(string(mu1p, 3), string(sigma1p,3), string(mu2p,3), string(sigma2p,3), string(p1p,3));
  //  write(ll, llp, r);
  if (r>1 || r*randMax>rand()) {
    mu1 = mu1p;
    sigma1 = sigma1p;
    mu2 = mu2p;
    sigma2 = sigma2p;
    p1 = p1p;
    ll = llp;
  }
  if (t>=burnin) {
    mu1post.add(mu1);
    sigma1post.add(sigma1);
    mu2post.add(mu2);
    sigma2post.add(sigma2);
    p1post.add(p1);
  }
}

write(mu1post.mean(), mu1post.sd());
write(sigma1post.mean(), sigma1post.sd());
write(mu2post.mean(), mu2post.sd());
write(sigma2post.mean(), sigma2post.sd());
write(p1post.mean(), p1post.sd());
