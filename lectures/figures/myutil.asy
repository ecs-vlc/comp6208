settings.outformat="pdf";
usepackage("bm");
usepackage("amsmath");
usepackage("amsfonts");
texpreamble("\DeclareMathAlphabet{\mat}{U}{eur}{b}{n}");
texpreamble("\newcommand{\tr}{\mathsf{T}}");

void ship() {
  static int n=0;
  string fn = outprefix() + "-" + string(n);
  ++n;
  shipout(fn);
}
