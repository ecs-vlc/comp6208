import cakes;
size(3cm,0);
pair A = (0,0);
pair B = (10,0);
pair C = (5,0);
node(A,"A");
node(B,"B");
node(C,"C");
depend(A,C);
depend(B,C);
 
