% cheat_sheet_template.cls
% 	Dokumentclass for easy generation of cheat sheets
% 	2022/12/11 Oscar von Loehneysen - ofreiherr@student.ethz.ch
% 	Version 0.

\ProvidesClass{cheat_sheet_template}[2022/12/10 version 0.1]
\NeedsTeXFormat{LaTeX2e}

% basic documentclass and packages
\LoadClass[8pt,a4paper,draft, landscape]{article}
\RequirePackage{ifthen}
%\RequirePackage{comment}
\RequirePackage{xcolor}
\RequirePackage{calc} %nessary for minipage width - xcm
%\RequirePackage{newcent}
%\RequirePackage{microtype}
\definecolor{darkgreen}{rgb}{0,0.1,0.4}
\definecolor{title}{rgb}{0.8, 0.4, 0.2}
\definecolor{section}{rgb}{1, 0.6, 0.4}
\definecolor{subsection}{rgb}{1, 0.7, 0.45}
\definecolor{subsubsection}{rgb}{1, 0.8, 0.6}
\definecolor{titletext}{rgb}{0, 0, 0}
\definecolor{bigtitletext}{rgb}{1, 1, 1}
\definecolor{formula}{rgb}{0.95, 1.0, 1.0}

% Declare Options
\def\@language{german}
\def\@green{false}
\def\@noNumber{false}
\def\@cheatsheet{true}
\def\@notitle{true}
\DeclareOption{english}{\def\@language{english}}
\DeclareOption{greenSol}{\def\@green{true}}
\DeclareOption{noNumber}{\def\@noNumber{true}}
\DeclareOption{not_cheat_sheet}{\def\@cheat_sheet{false}}
\DeclareOption{wastespaceontitle}{\def\@notitle{false}}
\DeclareOption*{%
	\ClassWarning{cheat_sheet_template}{Unknown option '\CurrentOption'}%
}
\ProcessOptions\relax

% general layout
\RequirePackage{geometry}
\geometry{margin=0.5cm}
\RequirePackage{parskip}
% further layout packages and commands
\RequirePackage{multicol}
\usepackage{enumitem} %for space between items


\usepackage[compact]{titlesec}
\titlespacing{\section}{0pt}{*0}{*0}
\titlespacing{\subsection}{0pt}{*0}{*0}
\titlespacing{\subsubsection}{0pt}{*0}{*0}

\setlength{\parindent}{0pt}% No paragraph indent

\pagestyle{empty}
\setlength{\unitlength}{1cm}
\setlength\itemsep{0cm}
\setlength{\parskip}{0cm}
\setlength{\parindent}{0em}
\setlist[itemize]{noitemsep}
\setlist[enumerate]{noitemsep}

% math packages
\RequirePackage{amsmath}

%tikz 
\RequirePackage{tikz}


% new variables
\newcommand{\veranstaltung}[1]{\def\@veranstaltung{#1}}
\newcommand{\@veranstaltung}{\ClassError{cheat_sheet_template}{No \noexpand\veranstaltung given}{Please add the \noexpand\veranstaltung command to your preamble}}
\newcommand{\numberCols}[1]{\def\@numberCols{#1}}
\newcommand{\@numberCols}{\ClassError{cheat_sheet_template}{No \noexpand\semester given}{Please add the \noexpand\numberCols command to your preamble}}

% new commands
%code snippet
\newcommand{\code}[1]{\texttt{#1}}
% equation box        
\newcommand{\eqbox}[1]{ \setlength{\fboxsep}{1pt} \fcolorbox{section}{formula}{ \hspace{0.5em}$\displaystyle#1$\hspace{0.5em}} }

\newcommand{\itembox}[1] { \fcolorbox{black}{white}{\begin{minipage}{ \linewidth -0.3cm } \vspace{2pt} #1 \vspace*{2pt} \end{minipage} }}
% new environments
\renewcommand{\section}[1]{
    \Large\bfseries
    \setlength{\fboxsep}{0cm}

    \colorbox{section}{
        \begin{minipage}{ \linewidth -0.5cm }
            \vspace*{2pt}
            \leftskip2pt 
            \rightskip\leftskip
            {\color{titletext} #1 }
            \vspace*{2pt}
        \end{minipage}
    }
    \tiny
    }

%subsection color box
\renewcommand{\subsection}[1]{
    \tiny \bfseries
    \setlength{\fboxsep}{0cm}
    \colorbox{subsection}{
        \begin{minipage}{\linewidth  -0.3cm }
            \vspace*{2pt}
            \leftskip2pt 
            \rightskip\leftskip 
            {\color{titletext} #1}
            \vspace*{2pt}
        \end{minipage}
    }}
    
%subsubsection color box
\renewcommand{\subsubsection}[1]{
    \tiny \bfseries
    \setlength{\fboxsep}{0cm}
    \colorbox{subsubsection}{
        \begin{minipage}{\columnwidth -0.3cm}
            \vspace*{2pt}
            \leftskip2pt 
            \rightskip\leftskip
            {\color{titletext} #1}
            \vspace*{2pt}
        \end{minipage}
    }}    

% redefine maketitle
\renewcommand\@maketitle{%
   \bfseries
    \setlength{\fboxsep}{0cm}

    \colorbox{title}{
        \begin{minipage}{ \linewidth -0.4cm }
            \setlength{\parindent}{1pt}
            \setlength{\baselineskip}{0pt}
            \vspace*{2pt}
            \leftskip2pt 
            \rightskip\leftskip
            \begin{center}
                \Large \color{bigtitletext}  \@veranstaltung 
                \ifthenelse{\equal{\@cheatsheet}{true}}{ \-- \ifthenelse{\equal{\@language}{german}}{Spickzettel}{Cheat sheet}}{}
                \tiny  \\
                Oscar von Löhneysen - ofreiherr@ethz.ch \\
                Anna-Yaroslava Bodnar - abodnar@ethz.ch\\
                Version: \today
            \end{center}                
            \vspace*{2pt}
        \end{minipage}
    }
    \tiny
}

\AtBeginDocument{\begin{multicols*}{\@numberCols}}
\ifthenelse{\equal{\@notitle}{true}}{}{\AtBeginDocument{\maketitle}} 
\AtEndDocument{\end{multicols*}}