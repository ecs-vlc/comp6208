real pcGab(int a, int b, int c) { // P(C|A,B)
  real p;
  if (a==1 && b==1)
    p = 1;
  else if (a==1 || b==1)
    p = 0.95;
  else
    p = 0.05;
  if (c==1)
    return p;
  else
    return 1-p;
}

real pa(int a) { // P(A)
  if (a==1)
    return 0.2;
  else
    return 0.8;
}

real pb(int b) { // P(B)
  if (b==1)
    return 0.1;
  else
    return 0.9;
}

typedef real func(int, int, int); // define signature of general function

real expect(func f) { // compute expectations exhaustively
  real sum = 0;
  for (int a=0; a<=1; ++a) {
    for (int b=0; b<=1; ++b) {
      for (int c=0; c<=1; ++c) {
	sum += f(a,b,c)*pcGab(a,b,c)*pa(a)*pb(b);
      }
    }
  }
  return sum;
}

/* Define functions to find expectations */
/* These are all indicator funtions so I end up with probabilities */

real fc(int a, int b, int c) {
  return c;
}

real fabc(int a, int b, int c) {
  return a*b*c;
}


real fac(int a, int b, int c) {
  return a*c;
}

real fab(int a, int b, int c) {
  return a*b;
}


real fbc(int a, int b, int c) {
  return b*c;
}

real fa(int a, int b, int c) {
  return a;
}

real fb(int a, int b, int c) {
  return b;
}

real f(int a, int b, int c) {
  return 1;
}




write("Prob of cakes");
write("Check joint probability is normalised: ", expect(f));
write("P(A=1) = ", expect(fa));
write("P(B=1) = ", expect(fb));
write("P(A=1,B=1) = ", expect(fab));
write("P(A=1)*P(B=1) = ", expect(fa)*expect(fb));
write("P(C=1) = ", expect(fc));
write("P(A=1,B=1|C=1) = ", expect(fabc)/expect(fc));
write("P(A=1|C=1) = ", expect(fac)/expect(fc));
write("P(B=1|C=1) = ", expect(fbc)/expect(fc));
write("P(A=1|C=1)*P(B=1|C=1) = ", (expect(fac)/expect(fc))*(expect(fbc)/expect(fc)));
