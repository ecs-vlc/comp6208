import myutil;
import sos;
import stats;
size(200,0);


Sos sos = Sos();

for(int i=0; i<10; ++i) {
  sos.add(Gaussrand());
}

real r = Gaussrand();

sos.print();
sos.add(r);
sos.print();
sos.subtract(r);
sos.print();

for(int i=0; i<100000; ++i) {
  sos.add(Gaussrand());
}
sos.print();
