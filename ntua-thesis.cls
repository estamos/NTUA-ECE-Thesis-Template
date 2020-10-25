%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%	Template for typesetting Diploma Theses (pdfLaTeX version)
%%
%%	Evangelos Stamos , January 2019 - October 2020
%%	(estamos@e-ce.uth.gr)
%%	(https://estamos.github.io/)
%%
%%	(adopted from the NTUA template for diploma theses 
%%	[http://web.dbnet.ntua.gr/el/diplomas.html])
%%
%%	Last update: October 25, 2020
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%

\NeedsTeXFormat{LaTeX2e}[1994/06/01]

% Class Information
\def\filename{ntua-thesis}
\def\fileversion{1.0}
\def\filedate{2020/01/21}
\NeedsTeXFormat{LaTeX2e}[1996/12/01]
\ProvidesClass{ntua-thesis}[%
    \filedate\space\fileversion\space LaTeX document class.]
% Required Packages
\RequirePackage{ifthen}
\RequirePackage{graphicx}
\RequirePackage{fancyhdr}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions
\LoadClass[a4paper,11pt,english,greek,twoside]{book}

\usepackage[greek,english]{babel}
\usepackage[utf8]{inputenc}
\usepackage[LGR,T1]{fontenc}
% shortcuts for latin and greek text
	\newcommand{\tl}[1]{\textlatin{#1}}
	\newcommand{\tg}[1]{\textgreek{#1}}
% typeset short english phrases
	\newcommand{\en}[1]{\foreignlanguage{english}{#1}}

\providecommand\phantomsection{}
\usepackage{varwidth}
\usepackage{xstring}
\usepackage{array}
\usepackage{calculator}
\usepackage[hyphens]{url}
\usepackage{relsize} % used for font scaling

\pagestyle{fancy}

% Define macros to set thesis variables
\def\@supervisor{}              
\def\supervisor#1{\gdef\@supervisor{#1}}
\def\@firstExaminer{}               
\def\firstExaminer#1{\gdef\@firstExaminer{#1}}
\def\@secondExaminer{}               
\def\secondExaminer#1{\gdef\@secondExaminer{#1}}
\def\@subtitle{}                    
\def\subtitle#1{\gdef\@subtitle{#1}}
\def\@translator{}              
\def\translator#1{\gdef\@translator{#1}}
\def\@institution{}             
\def\institution#1{\gdef\@institution{#1}}
\def\@department{}              
\def\department#1{\gdef\@department{#1}}
\def\@division{}                    
\def\division#1{\gdef\@division{#1}}
\def\@lab{}                             
\def\lab#1{\gdef\@lab{#1}}
\def\@other{}                           
\def\other#1{\gdef\@other{#1}}
\def\@dedication{}              
\def\dedication#1{\def\@dedication{#1}}
\def\@uppertitleback{}      
\long\def\uppertitleback#1{\def\@uppertitleback{#1}}
\def\@middletitleback{}   
\long\def\middletitleback#1{\def\@middletitleback{#1}}
\def\@lowertitleback{}    
\long\def\lowertitleback#1{\def\@lowertitleback{#1}}
\def\@approval{}   
\long\def\approval#1{\def\@approval{#1}}
\def\@chaptercolor{}              
\def\chaptercolor#1{\gdef\@chaptercolor{#1}}
\def\@appendixcolor{}              
\def\appendixcolor#1{\gdef\@appendixcolor{#1}}
\def\@thesisurlcolor{}              
\def\hyperlinkcolor#1{\gdef\@thesisurlcolor{#1}}
\def\@thesistitlecolor{}              
\def\titlecolor#1{\gdef\@thesistitlecolor{#1}}
\def\@frontpagetitlefillcolor{}              
\def\titlebackgroundcolor#1{\gdef\@frontpagetitlefillcolor{#1}}
\def\@keywordsGR{}              
\def\keywordsGR#1{\gdef\@keywordsGR{#1}}
\def\@keywordsEN{}              
\def\keywordsEN#1{\gdef\@keywordsEN{#1}}
\def\@subjectArea{}              
\def\subjectArea#1{\gdef\@subjectArea{#1}}
\def\@toutis{}              
\def\toutis#1{\gdef\@toutis{#1}}
\def\@authorNameCapitalGR{}   
\def\authorNameCapitalGR#1{\gdef\@authorNameCapitalGR{#1}}
\def\@authorNameCapitalEN{}   
\def\authorNameCapitalEN#1{\gdef\@authorNameCapitalEN{#1}}
\def\@authorNameGR{}   
\def\authorNameGR#1{\gdef\@authorNameGR{#1}}
\def\@authorNameEN{}   
\def\authorNameEN#1{\gdef\@authorNameEN{#1}}
\def\@supervisorTitle{}   
\def\supervisorTitle#1{\gdef\@supervisorTitle{#1}}
\def\@supervisorMaleFemale{}
\def\supervisorMaleFemale#1{\gdef\@supervisorMaleFemale{#1}}
\def\@thesisPlaceDate{}
\def\thesisPlaceDate#1{\gdef\@thesisPlaceDate{#1}}
\def\@ackPlaceDate{}
\def\ackPlaceDate#1{\gdef\@ackPlaceDate{#1}}
\def\@examinationDate{}
\def\examinationDate#1{\gdef\@examinationDate{#1}}
\def\@declarationDate{}
\def\declarationDate#1{\gdef\@declarationDate{#1}}
\def\@firstExaminerTitle{}
\def\firstExaminerTitle#1{\gdef\@firstExaminerTitle{#1}}
\def\@secondExaminerTitle{}
\def\secondExaminerTitle#1{\gdef\@secondExaminerTitle{#1}}
\def\@copyrightYear{}
\def\copyrightYear#1{\gdef\@copyrightYear{#1}}
\def\TRnumber#1{\gdef\@TRnumber{#1}}
\def\@trurl{}             
\def\trurl#1{\gdef\@trurl{\texttt{#1}}}
\def\@trftp{}             
\def\trftp#1{\gdef\@trftp{\texttt{#1}}}
\def\@usecoverpageimage{}
\def\@coverpageimagetikzcommands{}
\def\@coverpageimagefilename{}
\def\@coverpageimagescalefactor{}
\newcommand\coverpageimage[3][]{
    \gdef\@usecoverpageimage{1}
    \gdef\@coverpageimagescalefactor{#2}
    \IfStrEq{#1}{tikz}
    {
        \gdef\@coverpageimagetikzcommands{#3} 
    }
    {
        \gdef\@coverpageimagefilename{#3}
    }
}

\def\new@tpage{\newpage\thispagestyle{empty}\null}

% Measurements
\setlength{\oddsidemargin}{7mm}
\setlength{\evensidemargin}{0mm}
\setlength{\textwidth}{150mm}
\setlength{\topmargin}{10pt}
\setlength{\textheight}{245mm}
\setlength{\headheight}{50pt}
\advance \topmargin by -\headheight
\advance \topmargin by -\headsep


% Define color variables
\edef\titlepageshadecolor{}
\edef\colouredtextcolor{}
\edef\appendixcolouredtextcolor{}
\edef\logoshadecolor{}
\edef\titlefillcolor{}

\newcommand\preprocess{%
    % scale some fonts ("plain" option only)
        \ifmodernoption
            \def\chapterTitleScaleFactor{0.93}
        \else
            \def\chapterTitleScaleFactor{0.8}
        \fi
	% choose colors:
    	\ifprinteroption
    		\edef\@chaptercolor{black!70}
        	\edef\@appendixcolor{black!60}
            \edef\indexcolor{gray}
        	\edef\titlepageshadecolor{white}
        	\edef\colouredtextcolor{black!75}
        	\edef\appendixcolouredtextcolor{black!85}
        	\edef\logoshadecolor{white}
        	\edef\@thesisurlcolor{black}
        	\edef\@thesistitlecolor{black}
        	\edef\@frontpagetitlefillcolor{white}
            \edef\titlefillcolor{\@chaptercolor}
            % set grayscale logo
			\ifnewlogooption
                		\edef\logopath{logo/pyrforos.eps}
			\else
				\edef\logopath{logo/pyrforos.eps}
			\fi
    	\else
    	    % set color logo
			\ifnewlogooption
    	        		\edef\logopath{logo/pyrforos}
			\else
				\edef\logopath{logo/pyrforos.eps}
			\fi
    	    % check for undefined colors
    	        \ifx \@chaptercolor \@empty
    	            \message{LaTeX Warning: (ntua_thesis.cls): %
        			 Chapter color undefined. Using default.}%
        			 \typeout{ }%
        			 \def\@chaptercolor{brown!60!red}
    	        \else
    	        \fi
    	        \ifx \@appendixcolor \@empty
    	            \message{LaTeX Warning: (ntua_thesis.cls): %
        			 Appendix color undefined. Using default.}%
        			 \typeout{ }%
        			 \def\@appendixcolor{brown!60!orange}
    	        \else
    	        \fi
    	        \ifhyperrefoption
    	            \ifx \@thesisurlcolor \@empty
    	                \message{LaTeX Warning: (ntua_thesis.cls): %
        			    Hyperlink color undefined. Using default.}%
        			    \typeout{ }%
        			    \def\@thesisurlcolor{blue}
    	            \else
    	            \fi 
    	        \else
    	            \def\@thesisurlcolor{black}
    	        \fi
    	        \ifplainoption
    	        \else
    	            \ifx \@thesistitlecolor \@empty
    	                \message{LaTeX Warning: (ntua_thesis.cls): %
        			    Title color (cover page) undefined. Using default.}%
        			    \typeout{ }%
        			    \def\@thesistitlecolor{white}    	        
    	            \else
    	            \fi 
    	            \ifx \@frontpagetitlefillcolor \@empty
    	                \message{LaTeX Warning: (ntua_thesis.cls): %
        			    Title background color (cover page) undefined. Using chapter color.}%
        			    \typeout{ }%
        			    \def\@frontpagetitlefillcolor{\@chaptercolor}    	        
    	            \else
    	            \fi      	            
    	        \fi
    		\edef\indexcolor{\@appendixcolor}
			\edef\titlepageshadecolor{gray!50}
			\edef\colouredtextcolor{\@chaptercolor!70!black}
			\edef\appendixcolouredtextcolor{\@appendixcolor!70!black}
			\edef\logoshadecolor{\@chaptercolor}
            \edef\titlefillcolor{\@chaptercolor}
    	\fi
    % change equation number color
        \ifplainoption
            \makeatletter
                \def\tagform@##1{\maketag@@@{%
                    \color{\colouredtextcolor}(##1)\@@italiccorr}}
            \makeatother
        \else

            \makeatletter
                \def\tagform@##1{\maketag@@@{%
                    \colorbox{\colouredtextcolor}{\color{white}##1\@@italiccorr}}}
            \makeatother
        \fi
}

%%%
% Modify title command 
    \def\@titleincoverpage{}
	\let\oldtitle\title
	\renewcommand\title[2][]{%
		\oldtitle{#2}%
        \IfStrEq{#1}{}
            {
                \gdef\@titleincoverpage{#2}
            }
            {
                \gdef\@titleincoverpage{#1}
            }		
	}
% Format author strings  
\newcommand\compileauthors{%
    \ifx\@authorNameGR\@empty
    	\def\pdflistofauthors{\@authorNameEN}
    \else
        \ifx\@authorNameEN\@empty
    		\def\pdflistofauthors{\@authorNameGR}
    	\else
        	\def\pdflistofauthors{\@authorNameGR, \@authorNameEN}      
    	\fi     
    \fi	
    \edef\@authorNameCapitalEN{\@authorNameEN}
    \author{\pdflistofauthors}%
    \fullexpandarg\IfSubStr{\pdflistofauthors}{,}{\edef\@toutis{των}}{}%
}
%%%

% Maketitle 
\newcommand\formatauthorstringGR{%
	\StrSubstitute{\@authorNameCapitalGR}{,}{\protect\break}%
    [\formatedauthorstringGR]
}
\newcommand\formatauthorstringEN{%
	\StrSubstitute{\@authorNameCapitalEN}{,}{\protect\break}%
    [\formatedauthorstringEN]
}
\renewcommand{\maketitle}{
	\formatauthorstringGR%
    \formatauthorstringEN%
    \begin{titlepage}
        \let\footnotesize\small
        \let\footnoterule\relax
        \renewcommand{\thefootnote}{\fnsymbol{footnote}}
        \new@tpage
        % place NTUA Logo
        	\ifplainoption
			\ifnewlogooption
		            	\vspace{-2cm}
		            	\begin{raggedright}
					\begin{tabular}{ll}	
		                		\includegraphics[width=2.5cm]{\logopath}&
				        	\begin{minipage}[c]{15cm}
							\vspace{-2.5cm}
					            	\large{\textsc{\@institution}} \\
					            	\small{\textsc{\@department}} \\
					            	\textsc{\@division}
				        	\end{minipage}
					\end{tabular}
		             \end{raggedright}
		             \vspace{-12pt}
			\else
		            	\vspace{-2cm}
		            	\begin{center}
		                	\hfill
		                	\color{\colouredtextcolor}\raisebox{1.25cm}{\rule{6cm}{1pt}}
		                    \hfill
		                	\includegraphics[width=2.5cm]{\logopath}
		                    \hfill
		                    \color{\colouredtextcolor}\raisebox{1.25cm}{\rule{6cm}{1pt}}
		                    \hfill
		                \end{center}
		                \vspace{-12pt}
			\fi
            \else
            	\begin{tikzpicture}[remember picture,overlay]
	    			\node[align=left,yshift=-2.4cm] at (current page.north west)
	     			 	{
				      	\begin{tikzpicture}[remember picture, overlay]
				      		\shade[left color=\titlepageshadecolor, %
                            right color=white, draw=none] (0,0) rectangle
				          	(1cm,-\paperheight);
				        	\draw[fill=\titlepageshadecolor] (-5cm,0) rectangle
				          	(\paperwidth + 10cm,3cm);
						\ifnewlogooption
					        	\node[align=center,yshift=-1cm, xshift=\marginparwidth -\marginparsep %
	                            		,rectangle,
					            rounded corners=7pt,inner sep=8pt,
					            fill=\logoshadecolor!70, fill opacity=0.5, text opacity=1] 
					            {\includegraphics[width=1.85cm]{\logopath}};
						\else
					        	\node[align=center,xshift=\marginparwidth -\marginparsep +%
	                            		0.5*(\textwidth),rectangle,
					            rounded corners=7pt,inner sep=8pt,
					            fill=\logoshadecolor!70, fill opacity=0.5, text opacity=1] 
					            {\includegraphics[width=2.5cm]{\logopath}};
						\fi
				       \end{tikzpicture}
	       	      	};
	   			\end{tikzpicture}
	   			\centering\\[10pt]
            \fi
	    \centering
	\ifnewlogooption
		\vspace{-1cm}
	\fi
	\ifplainoption
		\ifnewlogooption
		\else
		        \Large\textsc{\@institution} \\
		        \large\textsc{\@department} \\
		        \textsc{\@division} \\
		\fi
	\else
	        \Large\textsc{\@institution} \\
	        \large\textsc{\@department} \\
	        \textsc{\@division} \\
	\fi
        \vspace{0.5cm}
        \vfill
        \ifplainoption
            \huge \textscale{\chapterTitleScaleFactor}{%
            \color{\colouredtextcolor}\textbf{\@titleincoverpage}}
        \else
            \scalebox{0.9}{%
				\begin{tikzpicture}			     
				    \node[align=center,rectangle,
                        rounded corners=10pt,inner sep=11pt,
                        shade, top color=\@frontpagetitlefillcolor, %
                        bottom color=\@frontpagetitlefillcolor!70] 
                        {\Large\color{\@thesistitlecolor}\chapterlabel%
                        \begin{varwidth}[t]{1.1\textwidth}
                            \centering\huge \bfseries %
                            \textscale{\chapterTitleScaleFactor}{\@titleincoverpage}%
                        \end{varwidth}};
                \end{tikzpicture}
	       	}
        \fi
        \\[10pt]
        \ifx\@subtitle\@empty
        \else
            \Large \textcolor{\colouredtextcolor}{\textit{\@subtitle}}\\
            {\color{\colouredtextcolor}\rule{3cm}{1pt}}
            \color{black}
        \fi
        %
        \vspace{0.1cm}
        %
        \vfill
        \huge \textcolor{\colouredtextcolor}{\textsc{\textscale{\chapterTitleScaleFactor}{%
            \@translator}}}
        \\[3mm]
        \normalsize \textcolor{black}{\@toutis}
        \\[3mm]
        \ifx\formatedauthorstringGR\@empty
            % do nothing
        \else
            \Large\textcolor{\colouredtextcolor}%
                {\textscale{\chapterTitleScaleFactor}{\textbf{\formatedauthorstringGR}}}
                \\
        \fi
        \ifx\formatedauthorstringEN\@empty
            % do nothing
        \else
            \Large\textcolor{\colouredtextcolor}%
            {\textscale{\chapterTitleScaleFactor}{\textbf{\en{\MakeUppercase{%
            \formatedauthorstringEN}}}}}
        \fi
        \vspace{0.2cm}
        \vfill        
        %
	    \ifx\@usecoverpageimage\@empty
        \else
            \begin{center}
                \ifx\@coverpageimagefilename\@empty
                    \ifx\@coverpageimagetikzcommands\@empty
                        \message{LaTeX Warning: (ntua_thesis.cls): %
            			No TikZ commands defined by \@backslashchar coverpageimage. %
            			Cover page image is omitted.}%
            			\typeout{ }
                    \else
                        \begin{tikzpicture}[scale=\@coverpageimagescalefactor]
                            \ifprinteroption
                                \selectcolormodel{gray}
                            \fi                        
                            \@coverpageimagetikzcommands
                        \end{tikzpicture}
                    \fi
                \else
                    \includegraphics[scale=\@coverpageimagescalefactor]{\@coverpageimagefilename}
                \fi
            \end{center}
        	\vspace{0.2cm}            
        \fi                 
        %
        \hspace{1mm}
        \begin{flushleft}
            \normalsize
            \begin{tabbing}
                \large \textcolor{\colouredtextcolor}%
                    {\textbf{\@supervisorMaleFemale :}} \=\@supervisor\\
                    \>\@supervisorTitle
            \end{tabbing}
        \end{flushleft}
        \vspace{0.2cm}
        \vfill
        %
        \ifplainoption
            \ifwatermarkoption
                \vfill
                \vfill
            \fi       
        \fi
        %
        \vspace{0.2cm}
        \vfill
        \normalsize \@thesisPlaceDate\\
        \ifplainoption
            \color{\colouredtextcolor}\rule{\textwidth}{1.5pt}\color{black}
        \else
            \tikz\shade[left color=\colouredtextcolor, %
                right color=\colouredtextcolor, draw=none] (0,0) %
                rectangle (\textwidth,0.8pt);
        \fi
            %
            \cleardoublepage
            \if@twoside\new@tpage
                \vspace{-1cm}
                \noindent
                \begin{minipage}[t]{\textwidth}
                    \@uppertitleback
                \end{minipage}
                \vspace{0.5cm}
                \vfill
                \centering
                \LARGE \textbf{\textcolor{\colouredtextcolor}{\@title}}
            	\ifx\@subtitle\@empty
                \else
                    \\[12pt]
                    \Large \textcolor{\colouredtextcolor}{\textit{\@subtitle}}\\
                    {\color{\colouredtextcolor}\rule{3cm}{1pt}}
                \fi
                %
                \vspace{0.1cm}
                \vfill
                %
                \huge{\textcolor{\colouredtextcolor}{\textscale{\chapterTitleScaleFactor}{%
                    \textsc{\@translator}}}}
                \\[3mm]
                \normalsize{\@toutis}
                \\[3mm]               
                \ifx\formatedauthorstringGR\@empty
                    % do nothing
                \else
                    {\Large\textcolor%
                	{\colouredtextcolor}%
                    {\textbf{\textscale{\chapterTitleScaleFactor}{\formatedauthorstringGR}}}}
                    \\
                \fi
                \ifx\formatedauthorstringEN\@empty
                    % do nothing
                \else
                    {\Large\textcolor%
                	{\colouredtextcolor}%
                    {\textbf{\en{\MakeUppercase{%
                    \textscale{\chapterTitleScaleFactor}{\formatedauthorstringEN}}}}}}
                \fi
                %
                \vspace{5mm}
                \vfill
                %
                \begin{tabbing}
                    \large \textcolor{\colouredtextcolor}%
                    {\textbf{\@supervisorMaleFemale :}} \=\@supervisor\\
                    \>\@supervisorTitle
                \end{tabbing}
                \vspace{5mm}
                \vfill
                \@approval
                \vfill
                \vspace{1cm}
                \@thesisPlaceDate
            %
            \fi
            \new@tpage
            \cleardoublepage
            \if@twoside\new@tpage
		\ifnewlogooption
            		\vspace{-1cm}
		\fi
                \noindent
                \begin{minipage}[t]{\textwidth}
                    \@uppertitleback
                \end{minipage}
                \par
                \vfill
                \noindent
                \begin{minipage}{\textwidth}
                    \@middletitleback
                \end{minipage}
                \par
                \vfill
                \noindent
                \begin{minipage}[b]{\textwidth}
                    \@lowertitleback
                \end{minipage}
            \fi
    \end{titlepage}
    %
    \renewcommand{\thefootnote}{\arabic{footnote}}
    \setcounter{footnote}{0}
    %
    \gdef\@thanks{}\gdef\@author{}\gdef\@translator{}\gdef\@institution{}
    \gdef\@department{}\gdef\@division{}\gdef\@lab{}\gdef\@other{}
    \gdef\@uppertitleback{}\gdef\@lowertitleback{}\gdef\@dedication{}%
    \gdef\@title{}\gdef\@subtitle{}\let\maketitle\relax%
}


% Names
\newcommand{\keywordsname}{Λέξεις Κλειδιά}
\newcommand{\keywordsnameeng}{\en{Keywords}}
\newcommand{\abstractname}{Περίληψη}
\newcommand{\abstractnameeng}{\en{Abstract}}
\newcommand{\draftname}{Προσχέδιο}
\newcommand{\prefacename}{Πρόλογος}
\newcommand{\acknowledgementsname}{Ευχαριστίες}
\newcommand{\pagesname}{Σελίδες}
\newcommand{\urlname}{\en{URL}}
\newcommand{\ftpname}{\en{FTP}}

% Define Illustrations environment
\usepackage{newfloat}
\DeclareFloatingEnvironment[
    fileext=loi,
    name=Eik'ona,
    placement=tbhp,
    within=chapter,
]{illustration}
    \addto\captionsgreek{%
      \renewcommand\listillustrationname{Kat'alogoc Eik'onwn}%
      }

% class options
	\newif\ifnewlogooption
	\newif\ifwatermarkoption
	\newif\ifmodernoption
	\newif\ifhyperrefoption
    \newif\ifprinteroption
    \newif\ifhistinitoption
    \newif\ifplainoption
    \newif\ifnoindexoption
    \printeroptionfalse
	\hyperrefoptionfalse
    \watermarkoptionfalse
    \modernoptionfalse
    \histinitoptionfalse
    \plainoptionfalse
    \noindexoptionfalse
	\newlogooptionfalse
	\DeclareOption{classic}{
		\modernoptionfalse
	}	
	\DeclareOption{modern}{
		\modernoptiontrue
	}
	\DeclareOption{hyperref}{
		\hyperrefoptiontrue
	}
	\DeclareOption{watermark}{
		\watermarkoptiontrue
	}
	\DeclareOption{printer}{
		\printeroptiontrue
	}
    \DeclareOption{histinit}{
		\histinitoptiontrue
	}
    \DeclareOption{plain}{
		\plainoptiontrue
	}    
	\DeclareOption{noindex}{
		\noindexoptiontrue
	}
	\DeclareOption{newlogo}{
		\newlogooptiontrue
	}
    
	\ProcessOptions
	\ifmodernoption
		% More Names
		\translator{Διπλωματικη Εργασια}
		\institution{Εθνικο Μετσοβιο Πολυτεχνειο}
		\department{Σχολη Ηλεκτρολογων Μηχανικων και Μηχανικων Υπολογιστων}
		\division{Τομεας}
		\other{}	
	\else
		% More Names
		\translator{Διπλωματική Εργασία}
		\institution{Εθνικό Μετσόβιο Πολυτεχνείο}
		\department{Σχολή Ηλεκτρολόγων Μηχανικών και Μηχανικών Υπολογιστών}
		\division{Τομέας}
		\other{}	
	\fi
    \ifprinteroption
    	\edef\@chaptercolor{gray}
        \edef\@appendixcolor{gray!80}
        \edef\titlepageshadecolor{white}
        \edef\colouredtextcolor{black}
        \edef\logoshadecolor{white}
        \edef\@thesisurlcolor{black}
        \edef\@thesistitlecolor{black}
        \edef\@frontpagetitlefillcolor{white}
    \else
    	% do nothing
    \fi
	\ifmodernoption
	 	 \usepackage{amsmath,amsthm,amssymb,kmath,kerkis}
         \usepackage[scaled=.75]{beramono}% scale tt font (url etc.)
	\else
		\usepackage{amsmath}
		\usepackage{amsthm}
		\usepackage{amssymb}
	\fi
	% Index generation
	\ifnoindexoption
		\newcommand\printindices{}
    	\newcommand*{\indexEN}[1]{}%
    	\newcommand*{\indexGR}[1]{}%    
   	 	\message{LaTeX Warning: (ntua_thesis.cls): The "noindex" option has %
   		 been selected. Index generation has been disabled. To allow index generation, %
    	 please remove the "noindex" option.}%
		\typeout{ }%
	\else
		\usepackage{imakeidx}
		\makeindex[name=greek,title=Ευρετήριο ελληνικών όρων,%
			intoc, columnseprule]
		\makeindex[name=english,title=Ευρετήριο ξενόγλωσσων όρων,%
			intoc, columnseprule]
		\newcommand*{\indexEN}[1]{\index[english]{#1@\foreignlanguage{english}{#1}}}
		\newcommand*{\indexGR}[1]{\index[greek]{#1}}
		\newcommand\printindices{%
 			\printindex[greek]
    		\renewcommand\indexname{Ευρετήριο ελληνικών όρων}
    		\pagestyle{indexpage}
			\printindex[english] 
    		\renewcommand\indexname{Ευρετήριο ξενόγλωσσων όρων}
    		\pagestyle{indexpage}    
    		\ifodd\value{page}
    			\clearpage
        		\pagestyle{empty}
    		\else
    		\fi
		}
	\fi    
	\ifhyperrefoption
	 	\usepackage[unicode]{hyperref}
		\usepackage{bookmark}
        \bookmarksetup{startatroot}
        %%%
 		% Modify title command to properly display title 
        % in PDF file properties
		\let\oldoldtitle\oldtitle
		\renewcommand\title[2][]{%
		    % temporarily set language commands to null
		        \let\olden\en
		        \renewcommand\en{}
		        \let\oldtextlatin\textlatin
		        \renewcommand\textlatin{}
		        \let\oldtextgreek\textgreek
		        \renewcommand\textgreek{}
		        \let\oldselectlanguage\selectlanguage
		        \renewcommand\selectlanguage{}
		    % strip title from TeX macros
		        \noexpandarg\StrDel{#2}{\\}[\strippedtitlestringtmp]
		        \noexpandarg\StrDel{\strippedtitlestringtmp}{\\*}[\strippedtitlestringtmptmp]
		        \noexpandarg\StrDel{\strippedtitlestringtmptmp}{\break}[\strippedtitlestring]
			\oldoldtitle{\strippedtitlestring}%
            \IfStrEq{#1}{}
                {
                    \gdef\@titleincoverpage{#2}
                }
                {
                    \gdef\@titleincoverpage{#1}
                }
            % restore language commands
		        \let\en\olden
		        \let\textlatin\oldtextlatin
		        \let\textgreek\oldtextgreek
		        \let\selectlanguage\oldselectlanguage
		}    
        %%%
	\else
	\fi
    \newcommand\setpdfproperties{%
		\ifhyperrefoption
        	\hypersetup%
			{colorlinks=true, linkcolor=\@thesisurlcolor,%
            urlcolor=\@thesisurlcolor,pdfencoding=auto, %
            citecolor=\@thesisurlcolor,pdfauthor={\@author},%
            pdftitle={\@title}, %
        	pdfcreator={ntua-thesis pdfLaTeX class (version \fileversion) %
            by Evangelos Stamos}}
        	\usepackage[all]{hypcap}
		\else
        	%% The following macros remain in the auxiliary files even when
            %% hyperref is disabled, causing "undefined control sequence" errors.
            %% Fixed by adding their dummy definitions.
			\newcommand\hyperindexformat[1]{}%
			\newcommand\hyperpage[1]{}%
		\fi    
    }
    \ifwatermarkoption
        \ifplainoption
        \else
	 	 	\usepackage{background}
         	\backgroundsetup{%
         	contents={\selectlanguage{greek}Diplwmatik'h Ergas'ia},%
         	angle=90, vshift=2.6cm,%
         	scale=3.4, color=gray}
        \fi
	\else
		% do nothing
	\fi	
%

\uppertitleback{
     \ifnewlogooption \vspace{-1.5cm} \fi
    \begin{minipage}{2cm}
		\ifnewlogooption
			\includegraphics[width=1.6cm]{\logopath}
		\else
        		\includegraphics[width=2cm]{\logopath}
		\fi
    \end{minipage}
    \ifnewlogooption
    \else
    		\hspace{0.5cm}
    \fi
    \begin{minipage}{12cm}
	    \ifmodernoption
		 	  \textsc{\@institution} \\
		      \textsc{\@department} \\
		      \textsc{\@division} 
		\else
		        \@institution \\
		        \@department \\
		        \@division 
		\fi		
    \end{minipage}
}

\approval{%
    Εγκρίθηκε από την τριμελή εξεταστική επιτροπή την \@examinationDate.\\[11pt]
    \begin{tabular}{ccc}	
     	\textit{(Υπογραφή)} &   \textit{(Υπογραφή)} &  \textit{(Υπογραφή)} \\[1.5cm]
        \dotfill & \dotfill & \dotfill \\
     	~\@supervisor~ &  ~\@firstExaminer~ & ~\@secondExaminer~ \\
 		~\@supervisorTitle~ &  ~\@firstExaminerTitle~ & ~\@secondExaminerTitle~ 
    \end{tabular}
}

\newcommand\declarationsingleauthor{%
Με πλήρη επίγνωση των συνεπειών του νόμου περί πνευματικών δικαιωμάτων, δηλώνω ενυπογράφως
ότι είμαι αποκλειστικός συγγραφέας της παρούσας Πτυχιακής Εργασίας, για την ολοκλήρωση της οποίας
κάθε βοήθεια είναι πλήρως αναγνωρισμένη και αναφέρεται λεπτομερώς στην εργασία αυτή. Έχω
αναφέρει πλήρως και με σαφείς αναφορές, όλες τις πηγές χρήσης δεδομένων, απόψεων, θέσεων και
προτάσεων, ιδεών και λεκτικών αναφορών, είτε κατά κυριολεξία είτε βάσει επιστημονικής παράφρασης.
Αναλαμβάνω την προσωπική και ατομική ευθύνη ότι σε περίπτωση αποτυχίας στην υλοποίηση των
ανωτέρω δηλωθέντων στοιχείων, είμαι υπόλογος έναντι λογοκλοπής, γεγονός που σημαίνει αποτυχία
στην Πτυχιακή μου Εργασία και κατά συνέπεια αποτυχία απόκτησης του Τίτλου Σπουδών, πέραν των
λοιπών συνεπειών του νόμου περί πνευματικών δικαιωμάτων. Δηλώνω, συνεπώς, ότι αυτή η Πτυχιακή
Εργασία προετοιμάστηκε και ολοκληρώθηκε από εμένα προσωπικά και αποκλειστικά και ότι,
αναλαμβάνω πλήρως όλες τις συνέπειες του νόμου στην περίπτωση κατά την οποία αποδειχθεί,
διαχρονικά, ότι η εργασία αυτή ή τμήμα της δεν μου ανήκει διότι είναι προϊόν λογοκλοπής άλλης
πνευματικής ιδιοκτησίας.%
}

\newcommand\declarationmultiauthors{%
Με πλήρη επίγνωση των συνεπειών του νόμου περί πνευματικών δικαιωμάτων, δηλώνουμε ενυπογράφως
ότι είμαστε αποκλειστικοί συγγραφείς της παρούσας Πτυχιακής Εργασίας, για την ολοκλήρωση της οποίας
κάθε βοήθεια είναι πλήρως αναγνωρισμένη και αναφέρεται λεπτομερώς στην εργασία αυτή. Έχουμε
αναφέρει πλήρως και με σαφείς αναφορές, όλες τις πηγές χρήσης δεδομένων, απόψεων, θέσεων και
προτάσεων, ιδεών και λεκτικών αναφορών, είτε κατά κυριολεξία είτε βάσει επιστημονικής παράφρασης.
Αναλαμβάνουμε την προσωπική και ατομική ευθύνη ότι σε περίπτωση αποτυχίας στην υλοποίηση των
ανωτέρω δηλωθέντων στοιχείων, είμαστε υπόλογοι έναντι λογοκλοπής, γεγονός που σημαίνει αποτυχία
στην Πτυχιακή μας Εργασία και κατά συνέπεια αποτυχία απόκτησης του Τίτλου Σπουδών, πέραν των
λοιπών συνεπειών του νόμου περί πνευματικών δικαιωμάτων. Δηλώνουμε, συνεπώς, ότι αυτή η Πτυχιακή
Εργασία προετοιμάστηκε και ολοκληρώθηκε από εμάς προσωπικά και αποκλειστικά και ότι,
αναλαμβάνουμε πλήρως όλες τις συνέπειες του νόμου στην περίπτωση κατά την οποία αποδειχθεί,
διαχρονικά, ότι η εργασία αυτή ή τμήμα της δεν μας ανήκει διότι είναι προϊόν λογοκλοπής άλλης
πνευματικής ιδιοκτησίας.%
}

\newcommand\declaration{%
	\edef\singleauthor{}
	\IfSubStr{\pdflistofauthors}{,}{}%
    	{\edef\singleauthor{yes}}%       
	\ifx\singleauthor\@empty
		\declarationmultiauthors
	\else
		\declarationsingleauthor 
	\fi
}

\newcommand\signature{%
	\ifx\singleauthor\@empty
		(Υπογραφές)
	\else
		(Υπογραφή)
    \fi
}

\newcommand*{\extractname}[2]{%
  \StrBetween[{#1},{\numexpr(#1)+1\relax}]{,#2,}{,}{,}%
}

\newcommand\signaturestable{%
    \StrCount{\@authorNameGR,}{,}[\numberofauthorsGR]
    \StrCount{\@authorNameEN,}{,}[\numberofauthorsEN]
    \ADD{\numberofauthorsGR}{\numberofauthorsEN}{\totalauthors}
    \DIVIDE{0.85}{\totalauthors}{\tablecolumnwidthfactor}
    \MIN{\tablecolumnwidthfactor}{0.3}{\tablecolumnwidthfactor}
    	\ifx\@authorNameGR\@empty%
		\else%
    		\foreach \n in {1,...,\numberofauthorsGR}{%
    			\parbox[t]{\tablecolumnwidthfactor\textwidth}%
                {\begin{spacing}{1} \raggedright\dotfill%
                \\\nohyphens{%
                \extractname{\n}%
                {\@authorNameGR}}%
                \end{spacing}}~~
                \ifx\n\numberofauthorsGR
                	\ifx\numberofauthorsEN 0
       				\else
                    	\hfill
                    \fi
                \else
                	\hfill
                \fi
        	}
		\fi%
    	\ifx\@authorNameEN\@empty%
		\else%
        	\selectlanguage{english}
    		\foreach \n in {1,...,\numberofauthorsEN}{%
    			\parbox[t]{\tablecolumnwidthfactor\textwidth}%
                {\begin{spacing}{1} \raggedright\dotfill%
                \\\nohyphens{%
                \extractname{\n}%
                {\@authorNameEN}}%
                \end{spacing}}~~
                \ifx\n\numberofauthorsEN\else\hfill\fi 
        	}
            \selectlanguage{greek}
		\fi%
		\\[12pt]%
		\@declarationDate%
} 

\middletitleback{%
    \vspace{1cm} 
    \textcolor{\colouredtextcolor}{\en{Copyright} \en{\copyright }}\en{ -- All rights reserved.} Με την επιφύλαξη παντός δικαιώματος.\\ %
	\ifx\@authorNameGR\@empty
	\else
        \@authorNameGR,
	\fi
	\ifx\@authorNameEN\@empty
	\else
        \en{\@authorNameEN},
	\fi 
    \@copyrightYear. 
    \\[12pt]
    Απαγορεύεται η αντιγραφή, αποθήκευση και διανομή της παρούσας εργασίας, εξ
    ολοκλήρου ή τμήματος αυτής, για εμπορικό σκοπό.  Επιτρέπεται η ανατύπωση,
    αποθήκευση και διανομή για σκοπό μη κερδοσκοπικό, εκπαιδευτικής ή
    ερευνητικής φύσης, υπό την προϋπόθεση να αναφέρεται η πηγή προέλευσης και να
    διατηρείται το παρόν μήνυμα.  
    \\[12pt]
    Το περιεχόμενο αυτής της εργασίας δεν απηχεί απαραίτητα τις απόψεις του Τμήματος, του Επιβλέποντα, ή της επιτροπής που την ενέκρινε. 
    \\[20pt]
    \textcolor{\colouredtextcolor}{\textbf{ΔΗΛΩΣΗ ΜΗ ΛΟΓΟΚΛΟΠΗΣ ΚΑΙ ΑΝΑΛΗΨΗΣ ΠΡΟΣΩΠΙΚΗΣ ΕΥΘΥΝΗΣ}}
    \\
	\declaration
    \\[24pt]
    \textit{\signature} 
    \\[40pt]
    \signaturestable
}


% Redefining Commands
\renewcommand{\frontmatter}{
    \cleardoublepage
    \@mainmatterfalse \pagenumbering{roman}
}
\renewcommand{\mainmatter}{
    \label{lastfront}
    \cleardoublepage
    \@mainmattertrue\pagenumbering{arabic}
    \addtocontents{toc}{\protect\addvspace{1em}}
}
\renewcommand{\backmatter}{
    \if@openright\cleardoublepage\else\clearpage\fi
    \@mainmatterfalse
}
% Headings
\def\invisiblethingie{\tiny\ }
\def\myemptypage{
    \mbox{}
    \vspace{\fill}
    \begin{flushright}
        \invisiblethingie
    \end{flushright}
    \vspace{5ex}
    \thispagestyle{empty}
}
%
\renewcommand{\cleardoublepage}{
    \clearpage %
    \if@twoside \ifodd\c@page\else
    \myemptypage
    \newpage
    \if@twocolumn\mbox{}\newpage\fi\fi\fi
}
%
\renewcommand{\chaptermark}[1]{
    \markboth{\mbox{\selectlanguage{greek}\@chapapp}\ \thechapter.\ \ #1}{}
%        \markboth{\mbox{\@chapapp}\ \thechapter.\ \ #1}{}
}
\renewcommand{\sectionmark}[1]{
    \markright{\thesection\ \ #1}{}
}
%
\fancyhf{}
\ifplainoption
	\ifwatermarkoption
    	\fancyfoot[RO]{%
        	\colorbox{\@chaptercolor}{\color{white}\textbf{\thepage}}
        }
    	\fancyfoot[LO]{%
        	\textcolor{\@chaptercolor}%
            {\selectlanguage{greek}\textit{Diplwmatik'h Ergas'ia}}
        } 
    	\fancyfoot[LE]{%
        	\colorbox{\@chaptercolor}{\color{white}\textbf{\thepage}}
        }
    	\fancyfoot[RE]{%
        	\textcolor{\@chaptercolor}%
            {\selectlanguage{greek}\textit{Diplwmatik'h Ergas'ia}}
        }       
    \else
    	\fancyfoot[LE,RO]{%
    		\colorbox{\@chaptercolor}{\color{white}\textbf{\thepage}}%
        }
    \fi
\else
	\fancyfoot[LE,RO]{%
	\tikz\node[fill=\@chaptercolor] (0,0){\color{white}\textbf{\thepage}};%
    }
\fi       	

\fancyhead[RO]{\footnotesize{{\color{\@chaptercolor}\rightmark}}}
\fancyhead[LE]{\footnotesize{{\color{\@chaptercolor}\leftmark}}}
\addtolength{\headheight}{2pt}
\setlength{\headwidth}{\textwidth}
\addtolength{\topmargin}{-2pt}
\fancypagestyle{plain}{ %
  \fancyhf{} % remove everything
  \renewcommand{\headrulewidth}{0pt} % remove lines as well
  \renewcommand{\footrulewidth}{0pt}
  \ifplainoption
	\ifwatermarkoption
    	\fancyfoot[RO]{%
        	\colorbox{\@chaptercolor}{\color{white}\textbf{\thepage}}
        }
    	\fancyfoot[LO]{%
        	\textcolor{\@chaptercolor}%
            {\selectlanguage{greek}\textit{Diplwmatik'h Ergas'ia}}
        } 
    	\fancyfoot[LE]{%
        	\colorbox{\@chaptercolor}{\color{white}\textbf{\thepage}}
        }
    	\fancyfoot[RE]{%
        	\textcolor{\@chaptercolor}%
            {\selectlanguage{greek}\textit{Diplwmatik'h Ergas'ia}}
        }
    \else
    	\fancyfoot[LE,RO]{%
    		\colorbox{\@chaptercolor}{\color{white}\textbf{\thepage}}%
        }
    \fi  
  \else
  	\fancyfoot[RO]{\tikz\node[fill=\@chaptercolor] (0,0)%
    {\color{white}\textbf{\thepage}};}
  \fi
  }
\fancypagestyle{indexpage}{ %
  \fancyfoot[RO]{\tikz\node[fill=\@chaptercolor] (0,0){\color{white}\textbf{\thepage}};}
  \fancyhead[RO]{\footnotesize{{\color{\@chaptercolor}\indexname}}}
  \fancyhead[LE]{\footnotesize{{\color{\@chaptercolor}\indexname}}}
  }
%
% More Enviroments
\newenvironment{keywords}{\section*{\color{\colouredtextcolor}\keywordsname}}{}
\newenvironment{keywordseng}{\section*{\color{\colouredtextcolor}\keywordsnameeng}}{}
\newcommand{\footacknowledgement}[1]{%
  \let\@tmp@makefntext\@makefntext%
  \long\def\@makefntext##1{%
      \parindent 1em%
      \noindent##1}%
  \footnotetext{#1}%
  \let\@makefntext\@tmp@makefntext% 
}
\newcommand\acksignatures{%
	\vspace{15pt}%
    \StrCount{\@authorNameGR,}{,}[\numberofauthorsGR]
    \StrCount{\@authorNameEN,}{,}[\numberofauthorsEN]
    \ADD{\numberofauthorsGR}{\numberofauthorsEN}{\totalauthors}
    \ifx\@authorNameGR\@empty%
    	\ifx\@authorNameEN\@empty%
        \else
    		\begin{flushright}
        		\begin{varwidth}[t]{\textwidth}%
            		\centering%
                	\ifx\@ackPlaceDate\@empty%
    				\else%
    					\@ackPlaceDate\\[10pt]%
    				\fi% 
        			\foreach \n in {1,...,\numberofauthorsEN}{%
            			\textit\en{{\extractname{\n}%
               			{\@authorNameEN}}}\\%
          			}%
      			\end{varwidth}
        	\end{flushright}                    
        \fi    
	\else%
    	\begin{flushright}
        	\begin{varwidth}[t]{\textwidth}%
            	\centering%
                \ifx\@ackPlaceDate\@empty%
    			\else%
    				\@ackPlaceDate\\[10pt]%
    			\fi%
    			\foreach \n in {1,...,\numberofauthorsGR}{%
               		\textit{\extractname{\n}%
               		{\@authorNameGR}}\\%
               	}%
                \ifx\@authorNameEN\@empty%
                \else
                   	\foreach \n in {1,...,\numberofauthorsEN}{%
               			\en{\textit{\extractname{\n}%
               			{\@authorNameEN}}}\\%
               		}%
                \fi
      		\end{varwidth}
        \end{flushright}
	\fi%
}
\newenvironment{acknowledgements}{%
  \chapter*{\acknowledgementsname\@mkboth{\acknowledgementsname}{\acknowledgementsname}}%
  \ifplainoption\else\phantomsection\fi%
  \addcontentsline{toc}{chapter}{\acknowledgementsname}%
}{\acksignatures}
\newenvironment{acknowledgements*}{%
  \chapter*{\acknowledgementsname\@mkboth{\acknowledgementsname}{\acknowledgementsname}}%
  \ifplainoption\else\phantomsection\fi%
  \addcontentsline{toc}{chapter}{\acknowledgementsname}%
}{}
\newenvironment{preface}{%
  \chapter*{\prefacename}\@mkboth{\prefacename}{\prefacename}%
  \ifplainoption\else\phantomsection\fi%
  \addcontentsline{toc}{chapter}{Πρόλογος}%
}{}
\def\abstract{%
  \chapter*{\abstractname\@mkboth{\abstractname}{\abstractname}}
  \ifplainoption\else\phantomsection\fi%
  \addcontentsline{toc}{chapter}{Περίληψη}
}
\def\abstracteng{
  \chapter*{\abstractnameeng\@mkboth{\abstractnameeng}{\abstractnameeng}}
  \ifplainoption\else\phantomsection\fi%
  \addcontentsline{toc}{chapter}{\abstractnameeng}
}
\def\endabstract{\par\vfil\null\endtitlepage}
%

% Misc

\AtEndDocument{\subparagraph{}\label{lastback}}
\let\oldbibliography\bibliography
\renewcommand\bibliography[1]{%
	\cleardoublepage%
    \ifhyperrefoption%
        \bookmarksetup{startatroot}%
	\else%
		% do nothing
	\fi%
	\oldbibliography{#1}%
    \addtocontents{toc}{\bigskip}%
	\addcontentsline{toc}{chapter}{Βιβλιογραφία}%
}

%% Dedication
\newcommand{\thesisDedication}[1]{%
	\cleardoublepage
	\thispagestyle{empty}
    ~\\
    \vfill
    \begin{flushright}
    	\textit{#1}
    \end{flushright}
    ~\\
    \vfill
    \pagebreak
}

%% Algorithm support
	% reset algorithm counter at every chapter
		\@addtoreset{algorithm}{chapter}
	% Algorithm environment
		\usepackage{algorithm,algorithmicx,algpseudocode}
		% enable floating algorithms
			\usepackage{float}
			\floatname{algorithm}{\begingroup\small\textcolor{\colouredtextcolor}{\textsc{Αλγοριθμος}}\endgroup}
		\renewcommand{\thealgorithm}{\begingroup\small\textcolor{\colouredtextcolor}%
			{\thechapter.\arabic{algorithm}}\endgroup}
		\renewcommand{\algorithmicrequire}{\textbf{Είσοδος:}}
		\renewcommand{\algorithmicensure}{\textbf{Έξοδος:}}
		\renewcommand{\algorithmicend}{\textbf{\textlatin{end}}}
		\renewcommand{\algorithmicif}{\textbf{\textlatin{if}}}
		\renewcommand{\algorithmicthen}{\textbf{\textlatin{then}}}
		\renewcommand{\algorithmicelse}{\textbf{\textlatin{else}}}
		\renewcommand{\algorithmicfor}{\textbf{\textlatin{for}}}
		\renewcommand{\algorithmicforall}{\textbf{\textlatin{for all}}}
		\renewcommand{\algorithmicdo}{\textbf{\textlatin{do}}}
		\renewcommand{\algorithmicwhile}{\textbf{\textlatin{while}}}
		\renewcommand{\algorithmicloop}{\textbf{\textlatin{loop}}}
		\renewcommand{\algorithmicrepeat}{\textbf{\textlatin{repeat}}}
		\renewcommand{\algorithmicuntil}{\textbf{\textlatin{until}}}
		\renewcommand{\algorithmicreturn}{\textbf{\textlatin{return}}}
% color horizontal lines in algorithm environment
	\newcommand\fs@coloruled{\def\@fs@cfont{}\let\@fs@capt\floatc@ruled
	  \def\@fs@pre{{\color{white}\hrule height.8pt depth0pt }\kern2pt}%
	  \def\@fs@post{\vspace{-10pt}\kern2pt{\color{\colouredtextcolor}\rule{\textwidth}{1pt}\color{black}}\relax}%
	  \def\@fs@mid{\kern2pt{\color{\colouredtextcolor}\rule{\textwidth}{1pt}\color{black}\vspace{5pt}}\kern2pt}%
	  \let\@fs@iftopcapt\iftrue}
	% apply colored horizontal lines to algorithms
		\floatstyle{coloruled}
		\restylefloat{algorithm}

%% "listings" support
\usepackage{listings}
\lstset{extendedchars}
\begingroup
  \catcode0=12 %
  \makeatletter
  \g@addto@macro\lst@DefEC{%
    \lst@CCECUse\lst@ProcessLetter
    αάΑΆΒβΓγΔδΕΈεέΖζΗΉηήΘθΙΊΪιίϊΐκΚΛλΜμΝνΞξΟΌοόΠπΡρΣσςΤτύυΰΥΎΫφΦχΧψΨωώΩ% *** add Unicode characters ***
    ^^00% end marker
  }%
\endgroup
	


%% CD covers and labels

\usepackage{tikz} % allows drawing shapes
\ifplainoption
	\newcommand{\definecdlabeloffsets}[4]{}
    \newcommand{\createcdlabel}[5]{%
    	\message{LaTeX Warning: (ntua_thesis.cls): The "plain" option has %
    	been selected. CD label generation has been disabled.}%
		\typeout{ }%
    }
    \newcommand{\createcdcover}[5]{%
    	\message{LaTeX Warning: (ntua_thesis.cls): The "plain" option has %
    	been selected. CD cover generation has been disabled.}%
		\typeout{ }%
    }
\else
	\usetikzlibrary{decorations.text}
	\usepgflibrary{shapes}

	\newcommand{\definecdlabeloffsets}[4]{
		\edef\upperlabelxoffset{#1}
		\edef\upperlabelyoffset{#2}
		\edef\lowerlabelxoffset{#3}
		\edef\lowerlabelyoffset{#4}
	}

	\newcommand{\createcdlabel}[5]{
		\cleardoublepage
		\pagestyle{empty}    
		% Zero page margins
			\setlength{\oddsidemargin}{0mm}
			\setlength{\evensidemargin}{0mm}
			\setlength{\textwidth}{\paperwidth}	
			\setlength{\topmargin}{0mm}
			\setlength{\textheight}{\paperheight}
		\fontsize{7}{8.4}\selectfont
		\begin{tikzpicture}[remember picture, overlay]
	    	\ADD{-10.5}{\upperlabelxoffset}{\x} \ADD{-7.4}{\upperlabelyoffset}{\y}
	    	\node [shift={(\x cm,\y cm)}]  at %
            (current page.north east) % slightly change y value for finer adjustment
	        {%
	        \begin{tikzpicture}[remember picture, overlay]
	            \draw(0,0) % circle's center (relative)
					circle (2cm) % circle #1 radius
					circle (5.6cm);
			\ifnewlogooption
                		\node[draw=none, align=center] at (-3.5,1.2)%
                    		{\includegraphics[width=0.9cm]{\logopath}};
			\else
                		\node[draw=none, align=center] at (-3.5,1.2)%
                    		{\includegraphics[width=1.5cm]{\logopath}};
			\fi
                \node[draw=none, text width=3.3cm, align=center] at (-3.7,-0.5)%
                {\textbf{#2}};%
             	\node[draw=none, align=center] at (3.5,-0.5) %
                {\textbf{ΔΙΠΛΩΜΑΤΙΚΗ}  \\ \textbf{ΕΡΓΑΣΙΑ} \\[5pt] %
                	ΑΘΗΝΑ,  \\ #3 \\ #4};%
				\node[draw=none,text width=#5cm, align=center] at (0,3)%
                	{\fontsize{9}{10.8}\selectfont \textbf{#1} \fontsize{7}%
                    {8.4}\selectfont};   
	            \path [decorate,decoration={raise=-1ex, text along path, reverse path, %
                text align={center}, text={ETHNIKO METSOBIO POLUTEQNEIO - SQOLH HLEKTROLOGWN MHXANIKWN KAI MHXANIKWN UPOLOGISTWN}}] (4.7cm,-2.8cm) %
                arc (-30:210:5.45cm) ;
	        \end{tikzpicture}
	        };
	     	\ADD{-13.5}{\upperlabelxoffset}{\xx} \ADD{-12}{\upperlabelyoffset}{\yy}
	     	\node [shift={(\xx cm,\yy cm)}]  at %
            (current page.north east) % slightly change y value for finer adjustment
	        {%
	        \begin{tikzpicture}[remember picture, overlay]
	             \draw(0,0) % rectangle's center (relative)
				  	rectangle (6cm,2.5cm);
           		 \node[draw=none] at (3,1.25) {\textit{Θέση \en{barcode}}};     
	        \end{tikzpicture}
	        };		
		\end{tikzpicture}

		%% lower copy:
		\fontsize{7}{8.4}\selectfont
		\begin{tikzpicture}[remember picture, overlay]%
	    	\ADD{-10.5}{\lowerlabelxoffset}{\xxx} \ADD{-22.2}{\lowerlabelyoffset}{\yyy}
	    	\node [shift={(\xxx cm,\yyy cm)}]  at %
            (current page.north east) % slightly change y value for finer adjustment
	        {%
	        \begin{tikzpicture}[remember picture, overlay]
	            \draw(0,0) % circle's center (relative)
					circle (2cm) % circle #1 radius
					circle (5.6cm);%
			\ifnewlogooption
                		\node[draw=none, align=center] at (-3.5,1.2)%
                    		{\includegraphics[width=0.9cm]{\logopath}};	
			\else
                		\node[draw=none, align=center] at (-3.5,1.2)%
                    		{\includegraphics[width=1.5cm]{\logopath}};
			\fi
                \node[draw=none, align=center] at (3.5,-0.5) {\textbf{ΔΙΠΛΩΜΑΤΙΚΗ}  %
                	\\ \textbf{ΕΡΓΑΣΙΑ}  \\[5pt] ΑΘΗΝΑ,  \\ #3 \\ #4};%
               	\node[draw=none, text width=3.3cm, align=center] at (-3.7,-0.5)%
                	{\textbf{#2}};
				\node[draw=none,text width=#5cm, align=center] at (0,3) %
                	{\fontsize{9}{10.8}\selectfont \textbf{#1} \fontsize{7}%
                    	{8.4}\selectfont};   
	          	\path [decorate,decoration={raise=-1ex, text along path, %
                    reverse path, text align={center}, text={ETHNIKO METSOBIO POLUTEQNEIO - SQOLH HLEKTROLOGWN MHXANIKWN KAI MHXANIKWN UPOLOGISTWN}}]%
                    (4.7cm,-2.8cm) arc (-30:210:5.45cm);%
	        \end{tikzpicture}
	      };
	     \ADD{-13.5}{\lowerlabelxoffset}{\xxxx} \ADD{-26.8}{\lowerlabelyoffset}{\yyyy}
	     \node [shift={(\xxxx cm,\yyyy cm)}]  at %
         	(current page.north east) % slightly change y value for finer adjustment
	        {%
	     		\begin{tikzpicture}[remember picture, overlay]
	     			\draw(0,0) % rectangle's center (relative)
						rectangle (6cm,2.5cm);%
           			\node[draw=none] at (3,1.25) {\textit{Θέση \en{barcode}}};%      
	     		\end{tikzpicture}
	     	};		
		\end{tikzpicture}
		%
		\pagebreak
	}

	\newcommand{\createcdcover}[5]{
		\cleardoublepage
		\pagestyle{empty}
		% Zero page margins
			\setlength{\oddsidemargin}{0mm}
			\setlength{\evensidemargin}{0mm}
			\setlength{\textwidth}{\paperwidth}	
			\setlength{\topmargin}{0mm}
			\setlength{\textheight}{\paperheight}
		\fontsize{9}{10.8}\selectfont 
		\begin{tikzpicture}[remember picture, overlay]%
	    	\node [shift={(-10.5cm,-8.4cm)}]  at %
            	(current page.north east)% slightly change y value for finer adjustment
	        	{%
	        		\begin{tikzpicture}[remember picture, overlay]
						\draw[thick] (-5.8,-5.8) rectangle (5.8,5.8); 
						\draw[dashed] (-6,-6) rectangle (6,6); 
					\ifnewlogooption
						\node at (-4.6,3.4){\includegraphics[width=1.4cm]%
                    			{\logopath}};
					\else
						\node at (-4.6,4.4){\includegraphics[width=1.8cm]%
                    			{\logopath}};
					\fi
                   		\node[draw=none, text width=9cm, align=left] at (1,4.3) %
                        	{ΕΘΝΙΚΟ ΜΕΤΣΟΒΙΟ ΠΟΛΥΤΕΧΝΕΙΟ \\ ΣΧΟΛΗ ΗΛΕΚΤΡΟΛΟΓΩΝ ΜΗΧΑΝΙΚΩΝ ΚΑΙ ΜΗΧΑΝΙΚΩΝ ΥΠΟΛΟΓΙΣΤΩΝ \\ %
                            TΟΜΕΑΣ};%
                   		\node[draw=none, text width=9cm, align=center] at (0,2.3) %
                        	{ΔΙΠΛΩΜΑΤΙΚΗ ΕΡΓΑΣΙΑ};%
						\node[draw=none,text width=#5cm, align=center] at (0,0)%
                        	{\fontsize{11}{13.2}\selectfont \textbf{#1} %
                            \fontsize{8}{9.6}\selectfont};%   
                   		\node[draw=none, text width=7cm, align=center] at (0,-2.5)%
                        	{\textbf{#2}};
                   		\node[draw=none, text width=10cm, align=center] at (0,-4)%
                        	{\scalebox{0.7}{ΑΘΗΝΑ}};
                   		\node[draw=none, text width=5cm, align=center] at (0,-4.5)%
                        	{\scalebox{0.7}{#3 #4}};
	        		\end{tikzpicture}
	        	};	
		\end{tikzpicture}

		%% lower copy:
		\fontsize{9}{10.8}\selectfont 
		\begin{tikzpicture}[remember picture, overlay]
	    	\node [shift={(-10.5cm,-21.9cm)}]  at %
            	(current page.north east) % slightly change y value for finer adjustment
	        	{%
	        		\begin{tikzpicture}[remember picture, overlay]%
						\draw[thick] (-5.8,-5.8) rectangle (5.8,5.8);% 
						\draw[dashed] (-6,-6) rectangle (6,6);%
					\ifnewlogooption
						\node at (-4.6,3.4){\includegraphics[width=1.4cm]%
                    			{\logopath}};	
					\else
						\node at (-4.6,4.4){\includegraphics[width=1.8cm]%
                    			{\logopath}};
					\fi
                   		\node[draw=none, text width=9cm, align=left] at (1,4.3) %
                        	{ΕΘΝΙΚΟ ΜΕΤΣΟΒΙΟ ΠΟΛΥΤΕΧΝΕΙΟ \\ ΣΧΟΛΗ ΗΛΕΚΤΡΟΛΟΓΩΝ ΜΗΧΑΝΙΚΩΝ ΚΑΙ ΜΗΧΑΝΙΚΩΝ ΥΠΟΛΟΓΙΣΤΩΝ \\ %
                            TΟΜΕΑΣ};%
                   		\node[draw=none, text width=9cm, align=center] at (0,2.3) %
                        	{ΔΙΠΛΩΜΑΤΙΚΗ ΕΡΓΑΣΙΑ};%
						\node[draw=none,text width=#5cm, align=center] at (0,0)%
                        	{\fontsize{11}{13.2}\selectfont \textbf{#1} \fontsize{8}%
                            {9.6}\selectfont};   
                   		\node[draw=none, text width=7cm, align=center] at (0,-2.5)%
                        	{\textbf{#2}};
                   		\node[draw=none, text width=10cm, align=center] at (0,-4)%
                        	{\scalebox{0.7}{ΑΘΗΝΑ}};
                   		\node[draw=none, text width=5cm, align=center] at (0,-4.5)%
                        	{\scalebox{0.7}{#3 #4}};
	        	\end{tikzpicture}
	        };	
		\end{tikzpicture}
	%
	}
\fi

\usepackage{calc}

% Format Chapter Headers
	\usepackage[explicit]{titlesec}
	\usepackage{setspace}
	\ifmodernoption
	 	 \newcommand\titlefontsize{\LARGE}
         \newcommand\parttitlefontsize{\huge}
         \newcommand\chapternumberfontsize{\Huge}
	\else
		\newcommand\titlefontsize{\Large}
        \newcommand\parttitlefontsize{\Large}
        \newcommand\chapternumberfontsize{\huge}
	\fi	
	\newcommand*\chapterlabel{}
    \ifplainoption
    	\titleformat
			{\chapter} % command
			[display] % shape
			{\bfseries\color{\titlefillcolor}} % format
			{\Large{\chaptertitlename} \hspace{3pt}%
            		\colorbox{\titlefillcolor}{%
            		\chapternumberfontsize{\textcolor{white}{\thechapter}}}% 
                \\[12pt]
                \huge \textscale{\chapterTitleScaleFactor}{#1}
     		} % label 
			{0pt} % sep
			{
    			\vspace{-10pt}
                \rule{\textwidth}{1pt}
			} % before-code
			[
				%nothing
			] % after-code
    	\titleformat
			{name=\chapter,numberless} % command
			[display] % shape
			{\bfseries\color{\titlefillcolor}} % format
			{
                \huge \textscale{\chapterTitleScaleFactor}{#1}
			} % label 
			{0pt} % sep
			{
    			\vspace{-10pt}
                \rule{\textwidth}{1pt}
			} % before-code
			[
				%nothing
			] % after-code 
		\titlespacing{\chapter}{0pt}{35pt}{20pt}% 
		\titlespacing{name=\chapter,numberless}{0pt}{35pt}{10pt}% 
    \else       
		\titleformat{\chapter}[block]
	  		{\gdef\chapterlabel{}\normalfont\sffamily\Huge\bfseries\scshape}
	  		{\gdef\chapterlabel{\small\textgreek{\chaptertitlename}\huge %
            	~\thechapter{:} }}{0pt}
	  		{%
        		\titlefontsize \textcolor{white}{#1}%
        		\begin{tikzpicture}[remember picture,overlay]
	    			\node[align=left,yshift=-2.4cm] at (current page.north west)
	      			{
	      				\begin{tikzpicture}[remember picture, overlay]
	        				\draw[fill=\titlepageshadecolor] (0,0) rectangle %
                            	(\paperwidth + 10pt,3cm);
	        				\node[anchor=north west, align=left, %
                            	xshift=0.5*(\paperwidth - \textwidth),yshift=0.6cm,%
                                rectangle, rounded corners=15pt,inner sep=11pt,%
                                fill=\titlefillcolor]% 
	              				{\Large\color{white}\chapterlabel%
                                	\begin{varwidth}[t]%
                                    	{\textwidth - \widthof{\chapterlabel}}%
	              						{\raggedright%
                                        \begin{spacing}{1} %
                                        	\titlefontsize {#1}%
                                        \end{spacing}}%
                                        \end{varwidth}%
                                };
	       				\end{tikzpicture}
	      			};
	   			\end{tikzpicture}%     
	  		}%
    	\titlespacing{\chapter}{0pt}{-35pt}{20pt}%  
   \fi   
    
% Format Part Headers
	\newif\iftypesetappendices%
    \typesetappendicesfalse%
	\newcommand*\partlabel{}
    \ifplainoption
    	\titleformat
			{\part} % command
			[display] % shape
			{\bfseries\color{\titlefillcolor}} % format
			{\phantomsection\huge{\partname} \hspace{3pt}%
            	\colorbox{\titlefillcolor}{%
            	\chapternumberfontsize{\textcolor{white}{\thepart}}}%                
                \\[12pt]
                \Huge \textscale{\chapterTitleScaleFactor}{#1}%
     		} % label 
			{0pt} % sep
			{
    			\vspace{-10pt}
                \rule{\textwidth}{1pt}
			} % before-code
			[
				%nothing
			] % after-code
    	\titleformat
			{name=\part,numberless} % command
			[display] % shape
			{\bfseries\color{\titlefillcolor}} % format
			{
                \phantomsection\Huge #1
			} % label 
			{0pt} % sep
			{
    			\vspace{-10pt}
                \rule{\textwidth}{1pt}
			} % before-code
			[
				%nothing
			] % after-code  
    \else    
		\titleformat{\part}
	  		{\gdef\partlabel{}\normalfont\sffamily\Huge\bfseries\scshape}
	  		{\gdef\partlabel{\thispagestyle{empty}\Huge\thepart}}{0pt}
	  		{%
      			\phantomsection%
      			\begin{tikzpicture}[remember picture,overlay]
	    			\node[align=center,yshift=3cm] at (current page.west)
	      			{%
          				\iftypesetappendices%
            				\thispagestyle{empty}%
       						\edef\partboxcolor{\@appendixcolor}%
						\else%
							\edef\partboxcolor{\titlefillcolor}%
						\fi%
	      				\begin{tikzpicture}[remember picture, overlay]
            				\iftypesetappendices%
       							\draw[fill=\titlepageshadecolor] (0,0) rectangle%
                               		(\paperwidth + 10pt,3cm);
	        					\node[xshift=0.5*\paperwidth,align=center,rectangle,%
	              					rounded corners=15pt,inner sep=17pt,%
	              					fill=\partboxcolor] 
	              					{%
       									\parttitlefontsize \textcolor{white}{#1}%		
                  					};
							\else%
	        					\draw[fill=\titlepageshadecolor] (0,0) rectangle%
	          						(\paperwidth + 10pt,3cm);
	        					\node[xshift=0.5*\paperwidth, yshift=3cm, align=center,%
                                	circle, fill=\partboxcolor, inner sep=10pt, %
                                    minimum width=1.5cm, draw=black] %
	              					{%
										\Huge\color{white}\partlabel%
                  					};
	        					\node[xshift=0.5*\paperwidth, yshift=1cm, align=center,%
                                	anchor=north, rectangle, rounded corners=15pt,%
                                    inner sep=17pt, fill=\partboxcolor]% 
	              					{%
										\begin{varwidth}{\textwidth}%
                                        	\parttitlefontsize%
                                        	\textcolor{white}{#1}%
                    	            	\end{varwidth}%
                  					};
							\fi%
	       				\end{tikzpicture}
	      			};
	   			\end{tikzpicture}
	  	}%
	\fi

% Format Appendices
	\newcommand\appendices{%
    	\typesetappendicestrue%
    	\ifhyperrefoption%
        	\bookmarksetup{startatroot}%
		\else%
			% do nothing
		\fi%
	\edef\colouredtextcolor{\appendixcolouredtextcolor}%
    \part*{Παραρτήματα}
    \ifplainoption\else\phantomsection\fi%
    \appendix%
    \edef\titlefillcolor{\@appendixcolor}%
		\ifmodernoption%
	 	 	\renewcommand\titlefontsize{\Large}%
		\else%
			\renewcommand\titlefontsize{\normalsize}%
		\fi%
    \typesetappendicesfalse%
	}

% Define Custom Colors
\definecolor{ntua_red}{RGB}{190,65,65}
\definecolor{lightgray}{RGB}{233,233,233}


\usepackage{graphicx}
\usepackage{epstopdf}
\usepackage{indentfirst}
\usepackage{verbatim}
\usepackage{latexsym}
\bibliographystyle{ntua}
\usepackage{hyphenat}

% Name Definitions
\newtheorem{definition}{Ορισμός}
\newtheorem{proposition}{Πρόταση}
\newtheorem{theorem}{Θεώρημα}
\newtheorem{corollary}{Συμπέρασμα}
\newtheorem{lemma}{Λήμμα}
\newtheorem{example}{Παράδειγμα}
\newtheorem{remark}{Σημείωση}
\newtheorem{notation}{Συμβολισμός}
\newtheorem{law}{Νόμος}
\renewcommand{\thedefinition}{\arabic{chapter}.\arabic{definition}}
\renewcommand{\theproposition}{\arabic{chapter}.\arabic{proposition}}
\renewcommand{\thetheorem}{\arabic{chapter}.\arabic{theorem}}
\renewcommand{\thecorollary}{\arabic{chapter}.\arabic{corollary}}
\renewcommand{\thelemma}{\arabic{chapter}.\arabic{lemma}}
\renewcommand{\theexample}{\arabic{chapter}.\arabic{example}}
\newcommand{\set}[1]{\left\{#1\right\}}
\newcommand{\To}{\Longrightarrow}
\newcommand{\xml}{\en{XML}}

% Change figure, table, algorithm and illustration caption colors 
\usepackage{caption}
\captionsetup[figure]{labelfont={color=\colouredtextcolor},textfont={it}}
\captionsetup[table]{labelfont={color=\colouredtextcolor},textfont={it}}
\captionsetup[illustration]{labelfont={color=\colouredtextcolor},textfont={it}}
\captionsetup[algorithm]{labelfont={color=\colouredtextcolor},textfont={it}}

% Macros for list of abbreviations
\newcommand{\abbrevEN}[2]{\en{#1} \> \en{#2}\\ }
\newcommand{\abbrevGR}[2]{#1 \> #2\\ }
\newcommand\includeabbreviations[1]{%
	\chapter*{Συντομογραφίες - Αρκτικόλεξα  - Ακρωνύμια}%
	\addcontentsline{toc}{chapter}{Συντομογραφίες - Αρκτικόλεξα  - Ακρωνύμια}%
	\markboth{Συντομογραφίες - Αρκτικόλεξα  - Ακρωνύμια}%
    	{Συντομογραφίες - Αρκτικόλεξα  - Ακρωνύμια}%
    \input{#1}%
    %\cleardoublepage\pagestyle{empty}% Enumerate glossary pages if they are > 1 page
}

% Macros for glossary
\newcommand{\gloss}[2]{#1 \> \en{#2}\\ }
\newcommand\includeglossary[1]{%
	\chapter*{Απόδοση ξενόγλωσσων όρων}%
	\addcontentsline{toc}{chapter}{Απόδοση ξενόγλωσσων όρων}%
    \markboth{Απόδοση ξενόγλωσσων όρων}{Απόδοση ξενόγλωσσων όρων}%
    \input{#1}%
    \ifx\printindices\@empty
    	\relax
    \else
    	\ifodd\value{page}
    		\clearpage
        	\pagestyle{empty}
    	\else
    	\fi    
    \fi
    %
}

% Redefine illustration environment
\newenvironment{Illustration}[1][]%
{%
	\begin{illustration}[#1] 
		\ifhyperrefoption%
	 	 	\capstart%
		\else%
			% do nothing
		\fi%

}%
{%
	\end{illustration}
}%

% Add some extra space between numbers and captions 
% in list of figures/tables/illustrations
\makeatletter
     \renewcommand*\l@figure{\@dottedtocline{1}{1em}{3.2em}}
     \renewcommand*\l@table{\@dottedtocline{1}{1em}{3.2em}}
     \renewcommand*\l@illustration{\@dottedtocline{1}{1em}{3.2em}}
\makeatother

% Handle front- main- matter
\newcommand\beginfrontmatter{%
	\ifhyperrefoption
		\mainmatter
	\else
		\frontmatter
	\fi
}
\newcommand\beginmainmatter{%
	\ifhyperrefoption
		% do nothing
	\else
		\mainmatter
	\fi	
}

% Historiated initial option
\newcommand\InitialCharacter{}
\ifhistinitoption
	\usepackage{lettrine}
    \ifmodernoption
    	\renewcommand\InitialCharacter[1]{%
    		\lettrine[lines=2]%
			{\color{\colouredtextcolor}\scalebox{1.3}%
			{#1}}{}% 
		}
    \else
    	\renewcommand\InitialCharacter[1]{%
    		\lettrine[lines=2]%
			{\color{\colouredtextcolor}\scalebox{1.0}%
			{\textbf{#1}}}{}%
		}
    \fi
\else
    \renewcommand\InitialCharacter[1]{#1}
\fi


%  set line spacing 
\renewcommand{\baselinestretch}{1.2}

% typeset source code
\newcommand{\src}[1]{{\tt\en{#1}}}

% typeset a backslash
\newcommand{\bkslash}{\en{\symbol{92}}}

% Execute some code before and after \begin{document}
	\usepackage{etoolbox}
    \AtEndPreamble{\preprocess\compileauthors\setpdfproperties}%
    \AfterEndPreamble{\selectlanguage{greek}}%
%
\selectlanguage{greek}

\endinput

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CHANGE-LOG
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ---------------------------------------------
%% 29/09/2015 - version 1.5.2:
%% ---------------------------------------------
%% 1. Added Greek language support for the "listings" package. 
%%
%% ---------------------------------------------
%% 19/05/2015 - version 1.5.1:
%% ---------------------------------------------
%% 1. Introduced support for the "listings" package. 
%%
%% ---------------------------------------------
%% 28/04/2015 - version 1.5:
%% ---------------------------------------------
%% 1. Introduced support for typesetting algorithms. 
%%
%% ---------------------------------------------
%% 26/04/2015 - version 1.4:
%% ---------------------------------------------
%% 1. Introduced the "newlogo" option to typeset the thesis using the new 
%% (still unofficial?) logo. 
%%
%% ---------------------------------------------
%% 14/03/2015 - version 1.3.1:
%% ---------------------------------------------
%% 1. Fixed problem with missing "nohyphenation" language in MikTeX 
%% (uses the \nohyphens macro of the hyphenat package, instead). 
%%
%% ---------------------------------------------
%% 11/01/2015 - version 1.3:
%% ---------------------------------------------
%% 1. Allows the addition of an image on the cover page (optional). 
%%
%% ---------------------------------------------
%% 04/01/2015 - version 1.2.2:
%% ---------------------------------------------
%% 1. Added the "hyphens" option to the url package in order to fix long
%% urls not breaking over several lines.
%%
%% ---------------------------------------------
%% 21/12/2014 - version 1.2.1:
%% ---------------------------------------------
%% 1. Fixed "Package hyperref Warning: Token not allowed in a PDF string 
%% (Unicode): (hyperref) removing `\\' ..."
%% 2. Corrected class name in warning messages.
%%
%% ---------------------------------------------
%% 10/12/2014 - version 1.2:
%% ---------------------------------------------
%% 1. Cover page logo is printed in black and white, when the "printer" option
%% is selected. 
%% 2. Thesis title colors (foreground and background) can now be customized. 
%% Note that background color is not applicable if the "plain" option is set.
%% 3. Other minor fixes.
%%
%% ---------------------------------------------
%% 06/12/2014 - version 1.1:
%% ---------------------------------------------
%% 1. Introduced the "plain" option to deal with online compilation
%% timeouts (also provides an alternative appearance of the thesis).
%% 2. Introduced the "noindex" option to speed-up online compilation. 
%% 3. Auxiliary files need not be deleted after removing the hyperref option.
%% (by the dummy definition of the "\hyperindexformat" and "\hyperpage" macros
%% when hyperref is switched off).
%% 4. "Main.tex" made more tidy (macros for defining variables have
%% been introduced, instead of using "edef" statements).
%% 5. Other minor fixes. 
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
