import cakes;

size(3cm,0);
pair A = (0,0);
pair B = (10,0);
pair C = (5,-2);
pair D = (0,-4);
pair E = (10,-4);
node(A,"A");
node(B,"B");
node(C,"C",true);
node(D,"D");
node(E,"E");
depend(A,C);
depend(B,C);
depend(C,D);
depend(C,E);

 
