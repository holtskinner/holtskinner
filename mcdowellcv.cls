\ProvidesClass{mcdowellcv}[2015/12/15 v1.1.0 McDowell CV class]

% Set up the fonts according to options
\def\mainfontsize{11pt}
\def\mainfontface{Avenir Next}

\ProcessOptions\relax

% Set font size and paper type
\LoadClass[letterpaper,\mainfontsize]{article} 

% Set document margins
\usepackage[left=0.4in,top=0.2in,right=0.4in,bottom=0.27in]{geometry} 

% Set font face
\usepackage{fontspec}
\setmainfont[SmallCapsFeatures={Renderer=Basic},
Ligatures={TeX, NoCommon, NoDiscretionary}]{\mainfontface}

% Remove paragraph indentation
\usepackage[parfill]{parskip} 

% Required for boldface (\bf and \bfseries) tabular columns
\usepackage{array} 

% Required for ifthenelse statements
\usepackage{etoolbox} 

% Suppress page numbers
\pagestyle{empty} 

% Flexible tables
\usepackage{tabu}

% For custom margins
\usepackage{changepage}

% To customize lists
\usepackage{enumitem}
% Remove left margin from lists, suppress vertical item separation and set top 
% separation to a negative value to suppress a single parskip before lists
\setlist{leftmargin=*, noitemsep, topsep=-1\parskip}

% For spcaed small caps
\usepackage{microtype}

\DeclareMicrotypeSet*{smallcapsi} { 
	encoding = {OT1,T1,T2A,LY1,OT4,QX,T5,TS1,EU1,EU2},
	shape    = {sc*,si,scit}
}

%--------------------------------------------------------------------------------
%                                    Constants                                  -
%--------------------------------------------------------------------------------
\def\afterheaderspace{3pt}
\def\beforesectionheaderspace{4.75pt}
\def\sectionheadermargin{6pt}
\def\aftersectionheaderspace{-4pt}
\def\sectionheaderhrlueheight{0.5pt}
\def\aftersinglelinesubsectionheaderspace{-18.5pt}
\def\afterdoublelinesubsectionheaderspace{-10pt}
\def\aftermultilinesubsectionheaderspace{-6pt}
\def\afteremptysubsectionheaderspace{3pt}
\def\subsectionmargin{9pt}
\def\aftersubsectionspace{4pt}

%--------------------------------------------------------------------------------
%                            Header Setup and Printing                          -
%--------------------------------------------------------------------------------

% Address
\makeatletter

\newcommand\address[1]{\def\@address{#1}}
\address{}

\newcommand\printaddress{
	\small{\@address}
}

\makeatother

% Name
\makeatletter

\newcommand\name[1]{\def\@name{#1}}
\name{}

\newcommand\printname{
	\textbf{\LARGE\textls[110]{\textsc{\@name}}}
}

\makeatother

% Contacts
\makeatletter

\newcommand\contacts[1]{\def\@contacts{#1}}
\contacts{}

\newcommand\printcontacts{
	\small{\@contacts}
}

\makeatother

\makeatletter
\newcommand\makeheader{
	\begin{center}
		\begin{tabu} to 1\textwidth { X[l,m] X[2,c,m] X[r,m] }
			\printaddress & \printname & \printcontacts \\
		\end{tabu}	
	\end{center}
	\vspace*{\afterheaderspace}
}
\makeatother

%--------------------------------------------------------------------------------
%                            Sections and Subsections                           -
%--------------------------------------------------------------------------------

% Print a section header
\makeatletter
\newenvironment{cvsection}[1]{
	\vspace*{\beforesectionheaderspace}
	% Set text margins to equal \tabcolsep (6pt by default)
	\begin{adjustwidth}{\sectionheadermargin}{\sectionheadermargin}
		\textsc{\textbf{#1}}
	\end{adjustwidth}
	\smallskip
	\hrule height \sectionheaderhrlueheight
	\vspace*{\aftersectionheaderspace}
}{}
\makeatother

% Print a subsection
\makeatletter
% Define toggles checking if titles were defined
\newtoggle{lefttitledefined}
\newtoggle{centertitledefined}
\newtoggle{righttitledefined}

\newenvironment{cvsubsection}[4][1]{
	\notblank{#2}{\toggletrue{lefttitledefined}}{}
	\notblank{#3}{\toggletrue{centertitledefined}}{}
	\notblank{#4}{\toggletrue{righttitledefined}}{}
	\ifboolexpr{togl {lefttitledefined} or togl {centertitledefined} or togl {righttitledefined}}{
		\begin{tabu} to 1\textwidth { X[l,p] X[c,p] X[r,p] }
			\textbf{#2} & \textbf{#3} & \textbf{#4} \\
		\end{tabu}
		% Add space according to the specified number of lines
		\ifnumcomp{#1}{=}{1}{\vspace*{\aftersinglelinesubsectionheaderspace}}{
			\ifnumcomp{#1}{=}{2}{\vspace*{\afterdoublelinesubsectionheaderspace}}{
				\vspace*{\aftermultilinesubsectionheaderspace}
			}
		}
	}{
		\vspace*{\afteremptysubsectionheaderspace}
	}
	\togglefalse{lefttitledefined}
	\togglefalse{centertitledefined}
	\togglefalse{righttitledefined}
	\begin{adjustwidth}{\subsectionmargin}{\subsectionmargin}
}
{
	\end{adjustwidth}
	\vspace*{\aftersubsectionspace}
}
\makeatother