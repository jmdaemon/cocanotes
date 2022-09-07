\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{tuftebook}[2022/04/08 A book template format based on Edward Tufte\\'s books]

\RequirePackage{amsmath}    % Better math handling
\LoadClassWithOptions{book} % Inherit from book class
\RequirePackage{sidenotes}  % Put annotations, tables and figures in margins

\captionsetup{font=footnotesize, skip=4pt}
\RequirePackage[maxfloats=45]{morefloats} % Marginals require more mory for floats
\RequirePackage{marginfix} % Automatically adjust the side-floats nicely 
\newcommand{\caesar@letterspace}[1]{#1}% allow LuaLaTeX, LaTeX letterspacing
\RequirePackage[letterspace=150]{microtype}% microtypography

\@ifpackagelater{microtype}{2011/08/18}% xxx allow LaTeX and earlier microtype
{\renewcommand{\caesar@letterspace}[1]{\textls{#1}}}%
{\AtEndDocument{\ClassWarningNoLine{caesar_book}{Need newest microtype for letterspacing.}}}


\RequirePackage{geometry}
\geometry{
    paperwidth=210mm,
    paperheight=297mm,
    left=42pt,
    top=72pt,
    textwidth=320pt,
    marginparsep=20pt,
    marginparwidth=180pt,
    textheight=650pt,
    footskip=40pt,
}

\renewcommand{\normalsize}{\fontsize{10pt}{13pt}\selectfont}%
\renewcommand{\footnotesize}{\fontsize{8pt}{10pt}\selectfont}%

% fullwidth environment, text across textwidth+marginparsep+marginparwidth
\newlength{\overhang}
\setlength{\overhang}{\marginparwidth}
\addtolength{\overhang}{\marginparsep}
%
\newenvironment{fullwidth}
  {\ifthenelse{\boolean{@twoside}}%
     {\begin{adjustwidth*}{}{-\overhang}}%
     {\begin{adjustwidth}{}{-\overhang}}%
  }%
  {\ifthenelse{\boolean{@twoside}}%
    {\end{adjustwidth*}}%
    {\end{adjustwidth}}%
  }

\RequirePackage{titlesec,titletoc}% load the helper package
\RequirePackage{fmtcount}
\titleformat{\chapter}[display]
{\bfseries\Large\sf}
{\filleft
\textls{\MakeUppercase{\chaptertitlename}} \expandafter\textls\expandafter{\NUMBERstring{chapter}}}
{1.5ex}
{\titlerule
\vspace*{1.1ex}%
\filright}
[\vspace*{1.5ex}%
\titlerule]


\RequirePackage{fancyhdr}% helper package
\fancypagestyle{normal}{
    % \renewcommand{\headrulewidth}{0.4pt}% The running heads and feet do not have rules
    % \renewcommand{\footrulewidth}{0pt}
    \fancyhf{}% set up the page numbering 
    \fancyfoot[LE,RO]{\thepage}
    \fancyhead[RO]{\rightmark}
    \fancyhead[LE]{\leftmark}
}

% This is used for chapters
% Redefine the plain page style
\fancypagestyle{plain}{%
  \fancyhf{}%
  \fancyfoot[LE, RO]{\thepage}%
  \renewcommand{\headrulewidth}{0pt}% Line at the header invisible
  \renewcommand{\footrulewidth}{0pt}% Line at the footer visible
}

\RequirePackage{emptypage}

\renewcommand{\frontmatter}{\pagestyle{empty}}% the frontmatter is empty
\renewcommand{\mainmatter}{\cleardoublepage\pagestyle{fancy}}% mainmatter with page numbering
\RequirePackage{ragged2e} % \RaggedRight works better than \raggedright
\newcommand{\marginparstyle}{\footnotesize} % initialize style with start value
\long\def\@ympar#1{% redefine margin par to avoid too many macros in the document
  \@savemarbox\@marbox{\marginparstyle#1}% marginparstyle is a prefix to the marginpar text now
  \global\setbox\@currbox\copy\@marbox % the rest of the definition is taken from original LaTeX
  \@xympar}
\renewcommand*{\marginfont}{\marginparstyle}
% setup itemize and enumerate  
\RequirePackage[shortlabels]{enumitem}
\setlist[itemize]{leftmargin=*}

\newcommand\newthought[1]{%
   \addvspace{1.0\baselineskip plus 0.5ex minus 0.2ex}%
   \noindent\textsc{#1}%
}%
\ExplSyntaxOn
\NewDocumentCommand \sidecite { o o m }
{ 
  \IfNoValueOrEmptyTF{#1}
  {
    \IfNoValueOrEmptyTF{#2}
    {
      \sidenote{\fullcite{#3}}
    }
    {
      \sidenote{\fullcite[#2]{#3}}
    }
  }
  {
    \IfNoValueOrEmptyTF{#2}
    {
      \sidenote{\fullcite[#1]{#3}}
    }
    {
      \sidenote{\fullcite[#1][#2]{#3}}
    }
  }
}
\ExplSyntaxOff

\RequirePackage{caption}
% \RequirePackage[margincaption,outercaption,,wide]{sidecap}
% \sidecaptionvpos{figure}{t} 
\captionsetup{labelfont={sf,bf,footnotesize}}
\DeclareCaptionStyle{marginfigure}[]{labelfont={sf,bf,footnotesize}, font=footnotesize, justification=justified}
\DeclareCaptionStyle{sidecaption}[]{labelfont={sf,bf,footnotesize}, font=footnotesize, justification=justified, singlelinecheck=off}
\DeclareCaptionStyle{widefigure}[]{labelfont={sf,bf,footnotesize}, font=footnotesize}

\renewcommand{\normalsize}{\fontsize{10pt}{13pt}\selectfont}%
\renewcommand{\footnotesize}{\fontsize{8pt}{10pt}\selectfont}%


% vim:ft=tex
