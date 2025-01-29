%% 
%% 
%%    Klaus-Peter Zauner              School of Electronics & Computer Science
%%    Southampton, 07.03.2007         University of Southampton, SO17 1BJ U.K.
%%     _______________________        http://www.ecs.soton.ac.uk/~kpz/
%% __/  uosexamb.cls          \_______________________________________________
%%                                       Time-stamp: <2007-07-05 18:38:42 kpz>
%% 
%%
%%  LaTeX class to prepare exam forms with writing space for students printed
%%  on the question sheets.
%%
%%  The layout of the exams follows the COMP2009 exam from 2006/07
%%  developed by Denis Nicole and the implementation is an adaptation
%%  of Steve Gunn's uosexam.cls.
%%
%%
%% ___________________________________________________________________________
%% 456789-123456789-123456789-123456789-123456789-123456789-123456789-12345678
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{uosexamb}
              [2007/03/07 v0.1 LaTeX document class]
\newcommand{\baseclass}{book}
\RequirePackage{ifthen}
\newboolean{withAnswers}
\DeclareOption{answers}{\setboolean{withAnswers}{true}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{\baseclass}
}
\ProcessOptions\relax
\RequirePackage{calc}
\RequirePackage{lastpage}
\RequirePackage{fancyhdr}
%\RequirePackage{uarial}


\def\@checkoptions#1#2{
  \edef\@curroptions{\@ptionlist{\@currname.\@currext}}
  \@tempswafalse
  \@tfor\@this:=#2\do{
    \@expandtwoargs\in@{,\@this,}{,\@curroptions,}
    \ifin@ \@tempswatrue \@break@tfor \fi}
  \let\@this\@empty
  \if@tempswa \else \PassOptionsToClass{#1}{\baseclass}\fi
}
\@checkoptions{10pt}{{10pt}{11pt}{12pt}}
\PassOptionsToClass{a4paper}{\baseclass}
\ProcessOptions\relax
\LoadClass{\baseclass}
\usepackage[latin1]{inputenc}
\usepackage[T1]{fontenc}
%\usepackage{uarial}
\usepackage{helvet}
\renewcommand*\familydefault{\sfdefault}
\renewcommand{\normalsize}{\fontsize{12}{14pt}\selectfont}
\usepackage{version}
\usepackage{lastpage}
\usepackage{fancyhdr}
\usepackage{fancybox}
\usepackage{graphpap}
\renewcommand{\headrulewidth}{0.0pt}


% \fancypagestyle{coverpage}{
%     \fancyhf{}
%     \fancyfoot[C]{\small Copyright~\copyright~\ifthenelse{\value{semnumber} > 1}{\arabic{yearplus1}}{\arabic{year}}~\univname}
%     \fancyfoot[R]{\small Number of pages~\pageref{LastPage}}
% }
\fancypagestyle{coverpage}{
    \fancyhf{}
    \fancyfoot[C]{}
    \fancyfoot[R]{}
}
\fancypagestyle{frontmatter}{
    \fancyhf{}
 }
\fancypagestyle{body}{
    \fancyhf{}
    \fancyhead[C]{\Large Page~\thepage~of~\pageref{LastPage}}
    \fancyhead[R]{\Large \ucode W1}
    \fancyfoot[RO]{\Large \textbf{TURN OVER}}
}
\fancypagestyle{last}{
    \fancyfoot{}
    \fancyfoot[C]{\Large \textbf{END OF PAPER}}
}
\usepackage{setspace}
\singlespacing
\setlength{\parindent}{0pt}
\setlength{\parskip}{2.0ex plus0.5ex minus0.2ex}
\usepackage{xspace}
\usepackage{vmargin}
\setmarginsrb           { 2.8cm}  % left margin
                        { 2.5cm}  % top margin
                        { 2.8cm}  % right margin
                        { 3.4cm}  % bottom margin
                        {  20pt}  % head height
                        {  25pt}  % head sep
                        {  17pt}  % foot height
                        {  25pt}  % foot sep

\usepackage{graphicx}
\usepackage{color}
\usepackage{epstopdf}
\usepackage{eso-pic}
\usepackage{type1cm}
\usepackage{colortbl}



\newcounter{year}
\newcounter{yearplus1}
\newcounter{semnumber}
\newcounter{sec}
\newcounter{question}
\newcounter{subquestion}[question]
\newcounter{marks}[question]
\newcounter{submarks}[question]
\newsavebox{\markstable}

\renewcommand{\labelenumi}{(\alph{enumi})}
\renewcommand{\labelenumii}{(\roman{enumii})}

% Do not reset figure counter
%\def\cl@chapter{\@elt{section}\@elt{footnote}}




\renewcommand{\section}{
     \stepcounter{sec}%
     \begin{flushleft}\textbf{\LARGE Section \Alph{sec}}\end{flushleft}%
}
 
% \renewcommand{\part}[1][0]{
%     \ifthenelse{\value{submarks} > 0}{%
%          \dispmarks{\thesubmarks}\setcounter{submarks}{0}}{}
%     \addtocounter{submarks}{#1}
%     \addtocounter{marks}{#1}
%     \item %
% }

\newlength{\markpos}
\setlength{\markpos}{1cm}
\newcommand{\mpos}[2][]{\setlength{\markpos}{#2}\ifthenelse{\equal{#1}{}}{}{\ifthenelse{\boolean{withAnswers}}{\setlength{\markpos}{#1}}{}}}

\newcommand{\dispmarks}[1]
{
    \hspace*{\fill}
%     \nolinebreak[1]
%    \newline
    \hspace*{\fill}
    \mbox{
    \textit{(#1~marks)}
    \makebox(0,0)[lt]{\raisebox{-\markpos}{\hspace*{1cm}\huge\fbox{$\frac{\rule{0pt}{1ex}}{#1}$}}}}\par
}


\renewcommand{\part}[3][0]{
    \addtocounter{submarks}{#1}
    \addtocounter{marks}{#1}
    \item #2%
    \sbox{\markstable}{\usebox{\markstable} \labelenumi~$\displaystyle\frac{\hspace{1em}}{#1}$}
    \ifthenelse{\value{submarks} > 0}{%
      \dispmarks{\thesubmarks}%
      \setcounter{submarks}{0}%
       }{}%
    #3%
}


% Usage:
%   \forloop[step]{counter}{initial_value}{conditional}{code_block}
% 
% For example:
%   \newcounter{ct} 
%   \forloop{ct}{1}{\value{ct} < 5}% {% \arabic{ct} } 
\newcommand{\forloop}[5][1]%
{%
  \setcounter{#2}{#3}%
  \ifthenelse{#4}%
  {%
    #5%
    \addtocounter{#2}{#1}%
    \forloop[#1]{#2}{\value{#2}}{#4}{#5}%
  }{}%
}% by nsetzer

\newcommand{\myline}{\textcolor[gray]{\linegrey}{\mbox{\rule{\textwidth}{\lineweight}}}}

% Lines for answers
\newcounter{linecount}
\newcommand{\lines}[1]{%
  \ifthenelse{\boolean{withAnswers}}{}{% not answers:
    \begin{Sbox}
      \begin{minipage}{\textwidth}%
        \rule{0pt}{\boxedlinespc}%
        \forloop{linecount}{0}{\value{linecount} < #1}{%
           \rule{0pt}{\boxedlinespc}%
           \textcolor[gray]{\linegrey}{\rule{\textwidth}{\lineweight}}\\%gray lines
        }%       
      \end{minipage}
    \end{Sbox}
    \vskip2mm
    \centerline{\fbox{\TheSbox}}
  }
}


% Numbered lines for answers
% Arguments:   - count of numbered blocks
%              - lines in each block    
\newcounter{count}
\newcounter{nlinecount}
\newcommand{\numberedlines}[2][1]{%
  \ifthenelse{\boolean{withAnswers}}{}{% not answers:
    \setcounter{count}{1}%
    \begin{Sbox}%
      \begin{minipage}{\textwidth}%
        \forloop{nlinecount}{0}{\value{nlinecount} < #2}{%
           \mbox{}\hfill{\Large \thecount $\;\;$}%
           \rule{0pt}{\boxedlinespc}%
           \textcolor[gray]{\linegrey}{\rule{0.95\textwidth}{\lineweight}}\\
           \addtocounter{count}{1}%
           \forloop{linecount}{1}{\value{linecount} < #1}{%
             \mbox{}\hfill%
             \rule{0pt}{\boxedlinespc}%
             \textcolor[gray]{\linegrey}{\rule{0.95\textwidth}{\lineweight}}\\
           }%
        }%       
      \end{minipage}
    \end{Sbox}
    \vskip2mm
    \centerline{\fbox{\TheSbox}}
  }

}

% Numbered lines for answers
% Arguments:   - count of numbered blocks
%              - lines in each block    
\newcounter{icount}
%\roman{icount}
\newcounter{inlinecount}
\newcommand{\inumberedlines}[2][1]{%
  \ifthenelse{\boolean{withAnswers}}{}{% not answers:
    \setcounter{icount}{1}%
    \begin{Sbox}%
      \begin{minipage}{\textwidth}%
        \forloop{inlinecount}{0}{\value{inlinecount} < #2}{%
           \mbox{}\hfill{\Large \roman{icount} $\;\;$}%
           \rule{0pt}{\boxedlinespc}%
           \textcolor[gray]{\linegrey}{\rule{0.95\textwidth}{\lineweight}}\\
           \addtocounter{icount}{1}%
           \forloop{linecount}{1}{\value{linecount} < #1}{%
             \mbox{}\hfill%
             \rule{0pt}{\boxedlinespc}%
             \textcolor[gray]{\linegrey}{\rule{0.95\textwidth}{\lineweight}}\\
           }%
        }%       
      \end{minipage}
    \end{Sbox}
    \vskip2mm
    \centerline{\fbox{\TheSbox}}
  }

}


% Rough work pages
\newcounter{rpagecount}
\newcommand{\roughwork}[1]{%
  \ifthenelse{\boolean{withAnswers}}{}{% not answers:
    \clearpage
    \forloop{rpagecount}{0}{\value{rpagecount} < #1}{%
      \nopagebreak
      \roughworklabel
      \vfill
      \vspace*{0.8\textheight}
%       \setlength{\unitlength}{3mm}
%       \centerline{\graphpaper[25](0,0)(180,270)}
      \vfill
      \roughworklabel
      \pagebreak
    }
  }
}

% Blank page (marked as blank)
\newcommand{\blankpage}[1][0.4]{%
  \ifthenelse{\boolean{withAnswers}}{}{% not answers:
    \clearpage
    \rule{0pt}{#1\textheight}
    \blankpagelabel
    \vfill
    \clearpage
  }% not answers
}

% Start new page
\newcommand{\freshpage}{%
  \ifthenelse{\boolean{withAnswers}}{}{% not answers:
    \clearpage
  }% not answers
}

% Start new page
\newcommand{\freshpagel}{%
  \ifthenelse{\boolean{withAnswers}}{}{% not answers:
    \vfill
    \blankarealabel
    \vfill
    \clearpage
  }% not answers
}



\newenvironment{parts}{
\begin{enumerate}}
{\sbox{\markstable}{\usebox{\markstable}\rule{0pt}{3ex} Total~$\displaystyle\frac{\hspace{1.2em}}{\themarks}$}%
\ifthenelse{\value{submarks} > 0}{%
\dispmarks{\thesubmarks}\setcounter{submarks}{0}}{%
  \begin{center}
    End of question~\thequestion
  \end{center}
  \begin{flushright}
    \fbox{\usebox{\markstable}}
  \end{flushright}
}\end{enumerate}
}



\newenvironment{question}[1]{
    \stepcounter{question}
    \newcommand{\totalmark}{#1}

    \textbf{\Alph{sec}~\thequestion}
}
{
    \ifthenelse{\value{marks} = 0}{\dispmarks{\totalmark}}{
        \ifthenelse{\value{marks} = \totalmark}{}{
            \ClassWarningNoLine{UoSExam}{Marks don't add up! (Question \thequestion)}
        }
    }
    \ifthenelse{\equal{\thepage}{\pageref{LastPage}}}
    {
        \thispagestyle{last}
    }{}
%     \clearpage
}

\ifthenelse{\boolean{withAnswers}}{
    \renewcommand{\arrayrulewidth}{1pt}
    \newenvironment{answer}%
    {
        \begin{flushleft}
        {\vskip 5pt \hrule height 1pt \vskip 0pt\relax}%
        \normalsize%\bfseries%
    }
    {%
        {\vskip 3.4pt \hrule height 1pt \vskip -5.4pt\relax}%
        \end{flushleft}
    }
    \makeatletter
    \ifthenelse{\equal{\thepage}{1}}{
        \AddToShipoutPicture{%
            \put(0,0){%
            \hspace{12cm}\raisebox{15cm}{\makebox(0,0){\rotatebox{55}{\textcolor[gray]{0.8}{\normalfont\fontsize{5cm}{5cm}\fontseries{m}\selectfont{Answers}}}}}
            }
        }
    }{}
    \makeatother
}
{\excludeversion{answer}
}

\newcommand{\qa}[2]{\ifthenelse{\boolean{withAnswers}}{{\vskip 5pt \hrule height 1pt \vskip 0pt\relax}#2{\vskip 3.4pt \hrule height 1pt \vskip -5.4pt\relax}}{\centerline{\fbox{\begin{minipage}{\textwidth}#1\end{minipage}}}}}

\newcommand{\qaf}[3][155mm]{\ifthenelse{\boolean{withAnswers}}{\centerline{\fbox{\begin{minipage}{\textwidth}\begin{center}\includegraphics[width=#1]{#3}\end{center}\end{minipage}}}}{\centerline{\fbox{\begin{minipage}{\textwidth}\begin{center}\includegraphics[width=#1]{#2}\end{center}\end{minipage}}}}}

\newcommand{\qabf}[3][155mm]{\ifthenelse{\boolean{withAnswers}}{\centerline{\fbox{\begin{minipage}{\textwidth}\begin{center}\includegraphics[width=#1]{#3}\end{center}\end{minipage}}}}{\centerline{\fbox{\begin{minipage}{155mm}\rule{155mm}{0pt}\vspace*{#2}\end{minipage}}}}}

\newcommand{\mylines}[1]{\centerline{\ifthenelse{\boolean{withAnswers}}{}{\fbox{\begin{minipage}{\textwidth}\begin{center}\includegraphics[width=155mm]{#1}\end{center}\end{minipage}}}}}

% emptyBox
\newcommand{\emptyBox}[1]{%
  \ifthenelse{\boolean{withAnswers}}{}{% not answers:
    \setlength\unitlength{1cm}\hspace{-10.5mm}\framebox(15.7,#1){}
  }
}


\usepackage[centerlast,Large,sc]{caption}
\setlength{\captionmargin}{20pt}
\newcommand{\fref}[1]{Figure~\ref{#1}}
\newcommand{\tref}[1]{Table~\ref{#1}}
\newcommand{\eref}[1]{Equation~\ref{#1}}
\newcommand{\cref}[1]{Chapter~\ref{#1}}
\newcommand{\sref}[1]{Section~\ref{#1}}
\renewcommand{\topfraction}{0.85}
\renewcommand{\textfraction}{0.1}
\renewcommand{\floatpagefraction}{0.75}
\usepackage[scriptsize]{subfigure}
\usepackage{booktabs}
\usepackage{rotating}
\def\thebibliography#1{
      \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
\reversemarginpar
\usepackage[pdfpagemode={None},bookmarks=true,bookmarksopen=false,
   bookmarksopenlevel=0,bookmarksnumbered=true,hypertexnames=false,
   colorlinks,linkcolor={blue},citecolor={blue},urlcolor={red},
   pdfstartview={FitV}, pdfpagelayout={TwoColumnLeft}, colorlinks=false]{hyperref}
\pdfstringdefDisableCommands{
   \let\\\space
   \let\spacefactor\space
   \let\@m\space
}
\newcommand*{\addresses}[1]{\def\addressnames{#1}}
\newcommand*{\university}[1]{\def\univname{#1}}
\newcommand*{\UNIVERSITY}[1]{\def\UNIVNAME{#1}}
\newcommand*{\department}[1]{\def\deptname{#1}}
\newcommand*{\DEPARTMENT}[1]{\def\DEPTNAME{#1}}
\newcommand*{\group}[1]{\def\groupname{#1}}
\newcommand*{\GROUP}[1]{\def\GROUPNAME{#1}}
\newcommand*{\faculty}[1]{\def\facname{#1}}
\newcommand*{\FACULTY}[1]{\def\FACNAME{#1}}
\newcommand*{\subject}[1]{\def\subjectname{#1}}
\newcommand*{\keywords}[1]{\def\keywordnames{#1}}
\newcommand*{\semester}[1]{\setcounter{semnumber}{#1}}
\newcommand*{\duration}[1]{\def\durationmins{#1}}
\newcommand*{\unitcode}[1]{\def\ucode{#1}}
\newcommand*{\unitTitle}[1]{\def\utit{#1}}
\newcommand*{\calculator}[1]{\def\calcoption{#1}}
\newcommand*{\usage}[1]{\def\usage{#1}}
\newcommand*{\boxedlinespc}[1]{\def\boxedlinespc{#1}}
\newcommand*{\roughworklabel}[1]{\def\roughworklabel{#1}}
\newcommand*{\blankpagelabel}[1]{\def\blankpagelabel{#1}}
\newcommand*{\blankarealabel}[1]{\def\blankarealabel{#1}}
\newcommand*{\linegrey}[1]{\def\linegrey{#1}}
\newcommand*{\lineweight}[1]{\def\lineweight{#1}}


\renewcommand*{\year}[1]{\setcounter{year}{#1}
                         \setcounter{yearplus1}{#1}
                         \stepcounter{yearplus1}
}
\newcommand*{\QtoBeAnswered}[1]{\def\qtba{#1}}
\newcommand*{\specialInstructions}[1]{\def\sinstr{#1}}
\newcommand*{\authors}[1]{\def\auths{#1}}
\university  {\texorpdfstring{\href{http://www.soton.ac.uk}
                {University of Southampton}}
                {University of Southampton}}
\UNIVERSITY  {\texorpdfstring{\href{http://www.soton.ac.uk}
                {UNIVERSITY OF SOUTHAMPTON}}
                {UNIVERSITY OF SOUTHAMPTON}}
\department  {\texorpdfstring{\href{http://www.ecs.soton.ac.uk}
                {School of Electronics and Computer Science}}
                {School of Electronics and Computer Science}}
\DEPARTMENT  {\texorpdfstring{\href{http://www.ecs.soton.ac.uk}
                {SCHOOL OF ELECTRONICS AND COMPUTER SCIENCE}}
                {SCHOOL OF ELECTRONICS AND COMPUTER SCIENCE}}
\group       {\texorpdfstring{\href{http://www.isis.ecs.soton.ac.uk}
                {Image, Speech and Intelligent Systems Group}}
                {Image, Speech and Intelligent Systems Group}}
\GROUP       {\texorpdfstring{\href{http://www.isis.ecs.soton.ac.uk}
                {IMAGE, SPEECH AND INTELLIGENT SYSTEMS GROUP}}
                {IMAGE, SPEECH AND INTELLIGENT SYSTEMS GROUP}}
\faculty     {\texorpdfstring{\href{http://www.engineering.soton.ac.uk}
                {Faculty of Engineering, Science and Mathematics}}
                {Faculty of Engineering, Science and Mathematics}}
\FACULTY     {\texorpdfstring{\href{http://www.engineering.soton.ac.uk}
                {FACULTY OF ENGINEERING, SCIENCE AND MATHEMATICS}}
                {FACULTY OF ENGINEERING, SCIENCE AND MATHEMATICS}}
\boxedlinespc{8mm}
\linegrey{0.68}
\lineweight{1.4pt}
\roughworklabel{\centerline{\ensuremath{\bullet\;\;}%
ROUGH WORK---THIS PAGE WILL NOT BE MARKED\ensuremath{\;\;\bullet}}}
\blankpagelabel{\centerline{\ensuremath{\bullet\;\;}%
This page is intentionally left blank---do 
not write in this space\ensuremath{\;\;\bullet}}}
\blankarealabel{\centerline{\ensuremath{\bullet\;\;}%
Do not write in this space\ensuremath{\;\;\bullet}}}


\newcommand{\fronthead}{
   \UNIVNAME \hfill \ucode W1
    \bigskip
    \rule{\textwidth}{1pt}
    \bigskip
    \ifthenelse{   \equal{\arabic{semnumber}}{3}              }
    {{SUPLAMENTAL~EXAMINATIONS~\arabic{year}/\arabic{yearplus1}}                                }
    {{SEMESTER~\arabic{semnumber}~EXAMINATION~\arabic{year}/\arabic{yearplus1}} }
    \\[0.2cm]
    {\MakeUppercase{\utit} \\[0.5cm]}
    {Duration:~\durationmins~mins \\}
    \bigskip
    \rule{\textwidth}{1pt}
    \vfill
}

\renewcommand{\maketitle}{
    \thispagestyle{coverpage}
    \ifthenelse{\boolean{withAnswers}}{}{
    \fbox{\fbox{Name: \hspace{7.2cm} Student ID: \hspace{4cm}}}
    \vspace{1ex}}
    \hrule
    {\MakeUppercase{\utit} \\[0.01cm]}
    \hrule
    \pagestyle{body}
  }
\endinput
%%
%% End of file `uosexam.cls'.
