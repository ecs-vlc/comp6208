prologues:=2;

verbatimtex
\documentclass[12pt]{article}
\usepackage{times}
\usepackage{mathptm}
\begin{document}
etex

defaultfont := "ptmr";
defaultscale := 1.2;

beginfig(0)
  vardef connection(expr i, j) =
    save li, c;
    path li, c[];
    li = pos[i]--pos[j];
    c[1] := li intersectionpoint node[i];
    c[2] := li intersectionpoint node[j];
    c[1]--c[2]
  enddef;
  pair pos[];
  pos[1] = (0,2cm);
  pos[2] = (0,-2cm);
  pos[3] = (4cm,2cm);
  pos[4] = (4cm,-2cm);
  pos[5] = (8cm,0);
  pos[6] = (10cm,0);
  pos[7] = (4cm,0.5cm);
  pos[8] = (4cm,-0.5cm);
  pos[9] = (8cm,1.5cm);
  path node[];
  for i=1,2,6,7,8,9:
    node[i] = fullcircle scaled 0.6cm shifted pos[i];
  endfor
  for i=3 upto 5:
    node[i] = fullcircle scaled 1cm shifted pos[i];
  endfor
  for i=1 upto 9:
    draw node[i];
  endfor;
  path l[];
  l[1] = connection(1,3);
  l[2] = connection(1,4);
  l[3] = connection(2,3);
  l[4] = connection(2,4);
  l[5] = connection(3,5);
  l[6] = connection(4,5);
  l[7] = connection(5,6);
  l[8] = connection(3,7);
  l[9] = connection(4,8);
  l[10] = connection(5,9);
  for i=1 upto 10:
    draw l[i];
  endfor;
  path sigmoid;
  sigmoid := (-0.3cm,-0.3cm){right}..(0.3cm,0.3cm){right};
  draw sigmoid shifted pos[3];
  draw sigmoid shifted pos[4];
  draw sigmoid shifted pos[5];
  label(btex $x_1$ etex, pos[1]);
  label(btex $x_2$ etex, pos[2]);
  label(btex $1$ etex, pos[7]);
  label(btex $1$ etex, pos[8]);
  label(btex $1$ etex, pos[9]);
  label(btex $\hat{y}$ etex, pos[6]);
  label.bot(btex $w^1_3$ etex, 1/2[pos[1],pos[3]]);
  label.bot(btex $w^1_4$ etex, 1/4[pos[1],pos[4]] shifted (-0.25cm,0));
  label.top(btex $w^2_3$ etex, 1/4[pos[2],pos[3]] shifted (-0.25cm,0));
  label.top(btex $w^2_4$ etex, 1/2[pos[2],pos[4]]);
  label.top(btex $w^3_5$ etex, 3/5[pos[3],pos[5]]);
  label.bot(btex $w^4_5$ etex, 3/5[pos[4],pos[5]]);
  label.rt(btex $b_3$ etex, 3/5[pos[3],pos[7]]);
  label.rt(btex $b_4$ etex, 3/5[pos[4],pos[8]]);
  label.rt(btex $b_5$ etex, 3/5[pos[5],pos[9]]);
  label.(btex \small 3 etex, pos[3] shifted (2.2mm,-2.2mm));
  label.(btex \small 4 etex, pos[4] shifted (2.2mm,-2.2mm));
  label.(btex \small 5 etex, pos[5] shifted (2.2mm,-2.2mm));
endfig

end;
