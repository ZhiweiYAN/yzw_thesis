%%
%% This is file `xjtuthesis.cls',
%% modified from `book.cls' provided with LaTeX base package in MiKTeX 2.2
%%
%% xjtuthesis is a LaTeX2e document class for Ph. D. theses of Xi'an Jiaotong University
%% It can be customized to be templates of Ph. D. theses of other Chinese universities and institutes
%% author: Shujun (Hook) Li (Lee), hooklee@hooklee.com, hooklee@mail.com
%% home page: http://www.hooklee.com
%% technical support: http://www.chinatex.org, http://www.ctex.org
%%
%% GNU GPL is as follows:
%%
%% xjtuthesis is a free software;
%% you can redistribute it and/or modify it under the terms of the
%% GNU General Public License as published by the Free Software Foundation;
%% either version 2 of the License, or (at your option) any later version.
%%
%% xjtuthesis is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
%% or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
%%
%% You should have received a copy of the GNU General Public License along with xjtuthesis;
%% if not, write to
%% the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{xjtuthesis}[2009/02/24 v0.1e
LaTeX document class for Ph. D. theses of Xi'an Jiaotong University]
\newcommand\@ptsize{0}
\newif\if@restonecol
\newif\if@openright \@openrightfalse
\newif\if@mainmatter \@mainmattertrue
\newif\if@XJTU@cjksmallfour \@XJTU@cjksmallfourfalse
\newif\if@XJTU@cjknormalfive \@XJTU@cjknormalfivefalse
%强行设置为双面模式以支持区分奇偶页眉页脚，引入另一个自定义的双面参数控制其他要素
\@twosidetrue
\newif\if@XJTU@twoside \@XJTU@twosidefalse
%打印纸的真正16开纸型参数是195mm×270mm
%学校要求的184mm×260mm是最后实际装订时裁掉边之后的结果
%因此比b5偏大，比16开偏小
%在Yap和GSview中，最接近16开参数的纸型是Executive: 184mm×267mm
\newif\if@XJTU@realsixteenkai \@XJTU@realsixteenkaifalse
\DeclareOption{16kaipaper}
   {\setlength\paperheight {270mm}%
    \setlength\paperwidth  {195mm}%
    \@XJTU@realsixteenkaifalse}
%学校要求的“真实”16开纸型184mm×260mm
\DeclareOption{16kaipaper2}
   {\setlength\paperheight {260mm}%
    \setlength\paperwidth  {184mm}
    \@XJTU@realsixteenkaitrue}
\DeclareOption{a4paper}
   {\setlength\paperheight {297mm}%
    \setlength\paperwidth  {210mm}}
\DeclareOption{a5paper}
   {\setlength\paperheight {210mm}%
    \setlength\paperwidth  {148mm}}
\DeclareOption{b5paper}
   {\setlength\paperheight {250mm}%
    \setlength\paperwidth  {176mm}}
\DeclareOption{letterpaper}
   {\setlength\paperheight {11in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{legalpaper}
   {\setlength\paperheight {14in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{executivepaper}
   {\setlength\paperheight {10.5in}%
    \setlength\paperwidth  {7.25in}}
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}
\DeclareOption{s4hao}{\@XJTU@cjksmallfourtrue\@XJTU@cjknormalfivefalse}
\DeclareOption{5hao}{\@XJTU@cjknormalfivetrue\@XJTU@cjksmallfourfalse}
\DeclareOption{oneside}{\@XJTU@twosidefalse\@mparswitchfalse}%\@twosidefalse
\DeclareOption{twoside}{\@XJTU@twosidetrue\@mparswitchtrue\@XJTUchapteropenrightfalse}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\DeclareOption{openright}{\@openrighttrue}
\DeclareOption{openany}{\@openrightfalse}
\DeclareOption{onecolumn}{\@twocolumnfalse}
\DeclareOption{twocolumn}{\@twocolumntrue}
\DeclareOption{openbib}{%
  \AtEndOfPackage{%
   \renewcommand\@openbib@code{%
      \advance\leftmargin\bibindent
      \itemindent -\bibindent
      \listparindent \itemindent
      \parsep \z@
      }%
   \renewcommand\newblock{\par}}%
}
%@XJTUxxx形式的定义为xjtuthesis.cls内部使用的变量
\newif\if@XJTUchapteropenright \@XJTUchapteropenrightfalse
\newif\if@XJTUhardcopy \@XJTUhardcopyfalse
\newif\if@XJTUenglishthesis \@XJTUenglishthesisfalse
\newif\if@XJTUcaphead \@XJTUcapheadfalse
\newif\if@XJTUdvipdfm \@XJTUdvipdfmfalse
\newif\if@XJTUdvips \@XJTUdvipsfalse
\newif\if@XJTUcoverdateinfoot \@XJTUcoverdateinfootfalse
\newif\if@XJTUcoverboxed \@XJTUcoverboxedfalse
\newif\if@XJTUnewgbkfonts \@XJTUnewgbkfontsfalse
\newif\if@XJTUextendedtoc \@XJTUextendedtocfalse
\newif\if@XJTUpartjuststarted \@XJTUpartjuststartedfalse
\newif\if@XJTUtoc@toc \@XJTUtoc@tocfalse
\newif\if@XJTUsloppy \@XJTUsloppyfalse% 控制是否在文档开始调用\sloopy
\newif\if@XJTUcontrolindent \@XJTUcontrolindenttrue%在某些特殊场合用于禁止\zihao的自动缩进
%\@XJTU@xxx形式的定义用于向其他宏包传递参数，或者控制调入哪些宏包
\newif\if@XJTU@cjkspace \@XJTU@cjkspacefalse% 缺省使用CJK*
\newif\if@XJTU@cjktilde \@XJTU@cjktildetrue% 缺省调用\CJKtilde
\newif\if@XJTU@supercite \@XJTU@supercitetrue% 缺省使用上标样式的参考文献引用文本
\newif\if@XJTU@psnfss \@XJTU@psnfssfalse
\newif\if@XJTU@typeicm \@XJTU@typeicmtrue 
\newif\if@XJTU@bookmarksopen \@XJTU@bookmarksopenfalse
\newif\if@XJTU@bookmarksnumbered \@XJTU@bookmarksnumberedtrue% 缺省在pdf书签中使用带数字的章节号
\newif\if@XJTU@pdfunicode \@XJTU@pdfunicodetrue
\newif\if@XJTU@fancybox \@XJTU@fancyboxfalse
\newif\if@XJTU@moresections \@XJTU@moresectionstrue
\newif\if@XJTU@indentfirst \@XJTU@indentfirsttrue
\newif\if@XJTU@mathpazo \@XJTU@mathpazofalse
\newif\if@XJTU@mathptmx \@XJTU@mathptmxfalse
%开始声明xjtuthesis的专用任选项
\DeclareOption{chapteropenright}{\@XJTUchapteropenrighttrue}
\DeclareOption{hardcopy}{\@XJTUhardcopytrue}
%\DeclareOption{electronic}{\@XJTUhardcopyfalse}
\DeclareOption{english}{\@XJTUenglishthesistrue\@XJTU@indentfirstfalse}
\DeclareOption{chinese}{\@XJTUenglishthesisfalse\@XJTU@indentfirsttrue}
\DeclareOption{caphead}{\@XJTUcapheadtrue}
%\DeclareOption{nocaphead}{\@XJTUcapheadfalse}
\DeclareOption{coverboxed}{\@XJTUcoverboxedtrue}
\DeclareOption{dvipdfmx}{\@XJTUdvipdfmtrue\@XJTUdvipsfalse}
\DeclareOption{dvipsx}{\@XJTUdvipstrue\@XJTUdvipdfmfalse}
\DeclareOption{newgbkfonts}{\@XJTUnewgbkfontstrue}%使用xjtu新GBK字体框架，正体为宋体，粗体为黑体，斜体为楷书
\DeclareOption{etoc}{\@XJTUextendedtoctrue\@XJTUtoc@toctrue}%将中英文摘要、目录、图表列表、附件等均列入目录中
\DeclareOption{notocintoc}{\@XJTUtoc@tocfalse}%禁止将目录本身放入目录
\DeclareOption{sloppy}{\@XJTUsloppytrue}%使用宽松的断行和断词策略，以避免中英文混排可能造成的错排
\DeclareOption{CJKspace}{\@XJTU@cjkspacetrue}%使用CJK代替CJK*
\DeclareOption{CJKnotilde}{\@XJTU@cjktildefalse}
\DeclareOption{bookmarksopen}{\@XJTU@bookmarksopentrue}
\DeclareOption{nobookmarksnumbered}{\@XJTU@bookmarksnumberedfalse}
\DeclareOption{nounicode}{\@XJTU@pdfunicodefalse}%不使用unicode模式
\DeclareOption{psnfss} {\@XJTU@psnfsstrue\@XJTU@typeicmfalse} % 使用 PostScript 字体替代 CM 字体，摘自cxterm的cjkctex.sty
\DeclareOption{mathpazo} {\@XJTU@psnfsstrue\@XJTU@mathpazotrue\@XJTU@mathptmxfalse} % 使用 mathpazo 字体替代 CM 字体
\DeclareOption{mathptmx} {\@XJTU@psnfsstrue\@XJTU@mathptmxtrue\@XJTU@mathpazofalse} % 使用 mathptmx 字体替代 CM 字体
\DeclareOption{notype1cm} {\@XJTU@typeicmfalse} % 不使用 Type1 CM 字体
\DeclareOption{fancybox} {\@XJTU@fancyboxtrue} % 载入fancybox宏包
\DeclareOption{moresections} {\@XJTU@moresectionstrue}
\DeclareOption{lesssections} {\@XJTU@moresectionsfalse}%这两个任选项用于调整目录中的缩进距离以防止文字交错
\DeclareOption{indentfirst} {\@XJTU@indentfirsttrue}%打开首段缩进
\DeclareOption{noindentfirst} {\@XJTU@indentfirstfalse}%禁止首段缩进
\DeclareOption{supercite} {\@XJTU@supercitetrue}%正常引用为上标引用
\DeclareOption{normalcite} {\@XJTU@supercitefalse}%正常引用为正文引用
\ExecuteOptions{16kaipaper,5hao,oneside,onecolumn,final}
\ProcessOptions

\if@XJTU@psnfss
   \RequirePackage[T1]{fontenc}
   \RequirePackage{textcomp}
   \if@XJTU@mathpazo
     \RequirePackage{mathpazo}
   \fi
   \if@XJTU@mathptmx
     \RequirePackage{mathptmx}
   \fi
   \RequirePackage[scaled]{helvet}
   \RequirePackage{courier}
\fi
\if@XJTU@typeicm
   \RequirePackage{type1cm}
\fi
\if@XJTU@fancybox
   \RequirePackage{fancybox}
\fi

\input{bk1\@ptsize.clo}

\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{1}
\setlength\parskip{0\p@ \@plus \p@}
%\setlength{\parskip}{3\p@ \@plus 1\p@ \@minus 1\p@}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
%以下部分参数按照Tianshu Wang的设置修改
\setcounter{topnumber}{2}
\renewcommand\topfraction{0.85}
\setcounter{bottomnumber}{1}
\renewcommand\bottomfraction{0.65}
\setcounter{totalnumber}{3}
\renewcommand\textfraction{.15}
\renewcommand\floatpagefraction{.6}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.7}
\renewcommand\dblfloatpagefraction{.5}
\newcommand\XJTU@schoolheading{Ph. D. Dissertation of Xi'an Jiaotong University}
\newcommand\setschoolheading[1]{\renewcommand\XJTU@schoolheading{#1}}
\newlength\XJTU@headruleheighti
\newlength\XJTU@headruleheightii
\setlength\XJTU@headruleheighti{1.2pt}
\setlength\XJTU@headruleheightii{0.4pt}
\newcommand\setheaderrule[2][0.4pt]{%
\clearpage\setlength\XJTU@headruleheighti{#2}\setlength\XJTU@headruleheightii{#1}}
\newcommand{\makeheadrule}{%
    \makebox[0pt][l]{\rule[.7\baselineskip]{\textwidth}{\XJTU@headruleheighti}}%
    \rule[.6\baselineskip]{\textwidth}{\XJTU@headruleheightii}\vskip-.8\baselineskip}
\newcommand\XJTU@headrule[1]{\hfil\parbox[b]{\textwidth}{\noindent\centerline{\XJTU@headerformat\mbox{#1}}\\\makeheadrule}\hfil}
% 下面是一个两端对齐的例子，注意中间的\hfill不能用\hfil替代
%\newcommand\XJTU@headrule[1]{\hfil\parbox[b]{\textwidth}{\XJTU@headerformat Left\hfill Right\\\makeheadrule}\hfil}
%设置页眉格式
\newcommand\XJTU@headerformat{\kai}
\newcommand\setheaderfont[1]{\renewcommand\XJTU@headerformat{#1}}
\newcommand\XJTU@footerformat{\kai}
\newcommand\setfooterfont[1]{\renewcommand\XJTU@footerformat{#1}}
%很奇怪！在单面模式下所有的页都被当成奇数页看待，从而造成偶数页眉页脚消失
%为解决这个问题，只好重定义了book.cls的oneside对象使得\twosidetrue始终成立
\def\ps@headings{%
    \def\@oddfoot{\XJTU@headerformat\hfil\XJTU@footerformat\thepage\hfil}%
    \def\@evenfoot{\XJTU@headerformat\hfil\XJTU@footerformat\thepage\hfil}%
    \def\@evenhead{\XJTU@headrule{\leftmark}}%
    \def\@oddhead{\XJTU@headrule{\XJTU@schoolheading}}%
    \let\@mkboth\markboth
\def\chaptermark##1{%
    \markboth {\MakeUppercase{%
    \ifnum \c@secnumdepth >\m@ne
        \if@mainmatter
        \@chapapp\ \thechapter. \ %
        \fi
    \fi
    ##1}}{}}%
\def\sectionmark##1{%
    \markright {
    \ifnum \c@secnumdepth >\z@
        \thesection. \ %
    \fi
    ##1}}}
\def\ps@altheadings{%
\def\@oddfoot{\XJTU@headerformat\hfil\XJTU@footerformat\thepage\hfil}%
\def\@evenfoot{\XJTU@headerformat\hfil\XJTU@footerformat\thepage\hfil}%
\def\@evenhead{\XJTU@headrule{\XJTU@schoolheading}}%
\def\@oddhead{\XJTU@headrule{\leftmark}}%
\let\@mkboth\markboth
\def\chaptermark##1{%
    \markboth {\MakeUppercase{%
    \ifnum \c@secnumdepth >\m@ne
        \if@mainmatter
        \@chapapp\ \thechapter. \ %
        \fi
    \fi
    ##1}}{}}%
\def\sectionmark##1{%
    \markright {
    \ifnum \c@secnumdepth >\z@
        \thesection. \ %
    \fi
    ##1}}}
%以下titlepage部分在xjtu_GB.cpx文件中重定义
\newenvironment{titlepage}
    {%
      \if@openright
        \cleardoublepage
      \else
        \clearpage
      \fi
      \if@twocolumn
        \@restonecoltrue\onecolumn
      \else
        \@restonecolfalse\newpage
      \fi
      \pagestyle{empty}
      \thispagestyle{titlepagefoot}%
      \setcounter{page}\@ne
    }%
    {%
    \if@restonecol\twocolumn \else \newpage \fi
     %\if@twoside\else
     %   \setcounter{page}\@ne
     %\fi
    }
\newcommand\maketitle{\begin{titlepage}%
  \let\footnotesize\small
  \let\footnoterule\relax
  \let \footnote \thanks
  \null\vfil
  \vskip 60\p@
  \begin{center}%
    {\LARGE \@title \par}%
    \vskip 3em%
    {\large
     \lineskip .75em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
      \vskip 1.5em%
    {\large \@date \par}%       % Set date in \large size.
  \end{center}\par
  \@thanks
  \vfil\null
  \end{titlepage}%
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@thanks\@empty
  %\global\let\@author\@empty
  %\global\let\@date\@empty
  %\global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
  \pagestyle{headings}
%  \frontmatter
}
%以上titlepage部分在xjtu_GB.cpx文件中重定义
\newcommand*\chaptermark[1]{#1}%原来的参数为空
\setcounter{secnumdepth}{2}
\newcounter {part}
\newcounter {chapter}
\newcounter {section}[chapter]
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]
\renewcommand \thepart {\@Roman\c@part}
\renewcommand \thechapter {\@arabic\c@chapter}
\renewcommand \thesection {\thechapter.\@arabic\c@section}
\renewcommand\thesubsection    {\thesection.\@arabic\c@subsection}
\renewcommand\thesubsubsection {\thesubsection.\@arabic\c@subsubsection}
\renewcommand\theparagraph     {\thesubsubsection.\@arabic\c@paragraph}
\renewcommand\thesubparagraph  {\theparagraph.\@arabic\c@subparagraph}
\newcommand\@chapapp{\chaptername}
\newcommand\frontmatter{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \pagestyle{headings}
  \@mainmatterfalse
  \pagenumbering{Roman}}%原为\pagenumbering{roman}
\newcommand\mainmatter{%
  \cleardoublepage
  \@mainmattertrue
  \pagenumbering{arabic}}
\newcommand\backmattername{Back Matter}
\newcommand\backmatter{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \@mainmatterfalse
  \refstepcounter{part}%
  \addcontentsline{toc}{part}{\backmattername}}
\newcommand\part{%
  \if@openright
     \cleardoublepage
  \else
     \clearpage
  \fi
%  \thispagestyle{plain}%
  \if@twocolumn
    \onecolumn
    \@tempswatrue
  \else
    \@tempswafalse
  \fi
  \null\vfil
  \secdef\@part\@spart}

\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >-2\relax
      \refstepcounter{part}%
      \addcontentsline{toc}{part}{\protect\numberline{\thepart}\hspace{1em}#2}%
    \else
      \addcontentsline{toc}{part}{#2}%
    \fi
    \markboth{\partname\nobreakspace\thepart. #1}{\partname\nobreakspace\thepart. #1}%
    {\centering
     \interlinepenalty \@M
     \normalfont
     \ifnum \c@secnumdepth >-2\relax
       \huge\bfseries \partname\nobreakspace\thepart
       \par
       \vskip 20\p@
     \fi
     \huge \bfseries #2\par}%
    \@endpart\if@openright\cleardoublepage\fi}
\def\@spart#1{%
    {\centering
     \interlinepenalty \@M
     \normalfont
     \Huge \bfseries #1\par}%
    \@endpart}
\def\@endpart{\vfil\newpage
              \if@twoside
               \if@openright
                \null
                \thispagestyle{empty}%
                \newpage
               \fi
              \fi
              \if@tempswa
                \twocolumn
              \fi}
\newcommand\chapter{\if@XJTUchapteropenright\cleardoublepage\else\clearpage\fi
                    %\thispagestyle{plain}%
                    \global\@topnum\z@
                    \if@XJTU@indentfirst\else%
                        \@afterindentfalse%当禁止首段缩进功能时打开
                    \fi%
                    \secdef\@chapter\@schapter}
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                       \if@mainmatter
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                       \fi
                       \if@mainmatter
                         \addcontentsline{toc}{chapter}%
                                   {\protect\numberline{\thechapter}#2}%
                       \else
                         \addcontentsline{toc}{chapter}{#2}%
                       \fi
                    \else
                      \addcontentsline{toc}{chapter}{#2}%
                    \fi
                    \chaptermark{#1}%
                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                    \fi}
%章标题自上而下的三个垂直间距
\newlength\XJTU@abovechap
\setlength\XJTU@abovechap{-\baselineskip}
\newlength\XJTU@chapmiddle
\setlength\XJTU@chapmiddle{0pt}
\newlength\XJTU@belowchap
\setlength\XJTU@belowchap{\baselineskip}
\newcommand\setchapvspaces[3][0pt]{%
\setlength\XJTU@chapmiddle{#1-\baselineskip}
\setlength\XJTU@abovechap{#2-\baselineskip}
\setlength\XJTU@belowchap{#3-\baselineskip}}
%中文论文中，“第X章”和标题之间的水平距离
\newlength\XJTU@chaplabelsep
\setlength\XJTU@chaplabelsep{1em}
\newcommand\setchaplabelsep[1]{\setlength\XJTU@chaplabelsep{#1}}
%定义黑体
\if@XJTUenglishthesis
    \newcommand\XJTU@bfseries{\bfseries}
\else
    \if@XJTUnewgbkfonts
        \newcommand\XJTU@bfseries{\bfseries}
    \else
        \newcommand\XJTU@bfseries{\hei}
    \fi
\fi
%定义章标题字体的命令
\newcommand\XJTU@chapformati{\Large\XJTU@bfseries}
\newcommand\XJTU@chapformatii{\Large\XJTU@bfseries}
\newcommand\setchapformat[2]{%
\renewcommand\XJTU@chapformati{\@XJTUcontrolindentfalse#1\@XJTUcontrolindenttrue}
\renewcommand\XJTU@chapformatii{\@XJTUcontrolindentfalse#2\@XJTUcontrolindenttrue}}
\def\@makechapterhead#1{%
  \vspace*{\XJTU@abovechap}%原为\vspace*{50\p@}
  {\centering\normalfont%原为\parindent \z@ \raggedright \normalfont 
    \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter
        \XJTU@chapformati \@chapapp\space \thechapter
        \par\nobreak
        \vskip \XJTU@chapmiddle%原为20\p@
      \fi
    \fi
    \interlinepenalty\@M
    \XJTU@chapformatii #1\par\nobreak
    \vskip \XJTU@belowchap%原为40\p@
  }}
\def\@schapter#1{\if@twocolumn
                   \@topnewpage[\@makeschapterhead{#1}]%
                 \else
                   \@makeschapterhead{#1}%
                   \@afterheading
                 \fi}
\def\@makeschapterhead#1{%
  \vspace*{\XJTU@abovechap}%原为\vspace*{50\p@}
  {\centering\normalfont%原为\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
    \XJTU@chapformatii #1\par\nobreak
    \vskip \XJTU@belowchap%原为40\p@
  }}
%定义小节字体的命令
\newcommand\XJTU@secformat{\Large\XJTU@bfseries}
\newcommand\XJTU@subsecformat{\large\XJTU@bfseries}
\newcommand\XJTU@subsubsecformat{\normalsize\XJTU@bfseries}
\newcommand\XJTU@paragraphformat{\normalsize\XJTU@bfseries}
\newcommand\XJTU@subparagraphformat{\normalsize\XJTU@bfseries}
\newcommand\setsecformat[2][section]{%
\ifthenelse{\equal{#1}{section}}{\renewcommand\XJTU@secformat{#2}}{}
\ifthenelse{\equal{#1}{subsection}}{\renewcommand\XJTU@subsecformat{#2}}{}
\ifthenelse{\equal{#1}{subsubsection}}{\renewcommand\XJTU@subsubsecformat{#2}}{}
\ifthenelse{\equal{#1}{paragraph}}{\renewcommand\XJTU@paragraphformat{#2}}{}
\ifthenelse{\equal{#1}{subparagraph}}{\renewcommand\XJTU@subparagraphformat{#2}}{}}
\newcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\normalfont\XJTU@secformat}}
\newcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\XJTU@subsecformat}}
\newcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\XJTU@subsubsecformat}}
\newcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {3.25ex \@plus1ex \@minus.2ex}%
                                    {-1em}%
                                    {\normalfont\XJTU@paragraphformat}}
\newcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                       {3.25ex \@plus1ex \@minus .2ex}%
                                       {-1em}%
                                      {\normalfont\XJTU@subparagraphformat}}
\if@twocolumn
  \setlength\leftmargini  {2em}
\else
  \setlength\leftmargini  {2.5em}
\fi
\leftmargin  \leftmargini
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\if@twocolumn
  \setlength\leftmarginv  {.5em}
  \setlength\leftmarginvi {.5em}
\else
  \setlength\leftmarginv  {1em}
  \setlength\leftmarginvi {1em}
\fi
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{\textbullet}
\newcommand\labelitemii{\normalfont\bfseries \textendash}
\newcommand\labelitemiii{\textasteriskcentered}
\newcommand\labelitemiv{\textperiodcentered}
\newenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\bfseries #1}
\newenvironment{verse}
               {\let\\\@centercr
                \list{}{\itemsep      \z@
                        \itemindent   -1.5em%
                        \listparindent\itemindent
                        \rightmargin  \leftmargin
                        \advance\leftmargin 1.5em}%
                \item\relax}
               {\endlist}
\newenvironment{quotation}
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item\relax}
               {\endlist}
\newenvironment{quote}
               {\list{}{\rightmargin\leftmargin}%
                \item\relax}
               {\endlist}
% The following command was modified on 24 Feb. 2009 to correct a bug of bookmarks of appendix.
\newcommand\appendix{\par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \gdef\@chapapp{\appendixname}%
  \renewcommand*{\theHchapter}{\thechapter}% 
  \gdef\thechapter{\@Alph\c@chapter}
  \renewcommand*{\theHchapter}{\thechapter}% This command is needed to avoid confusion between chapters of the main body and those of the appendix.
  \refstepcounter{part}% The following commands are needed to add a new entry \appendixname into the TOC.
  \addcontentsline{toc}{part}{\appendixname}%
  \addtocounter{part}{-1}}
\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\@addtoreset {equation}{chapter}
\renewcommand\theequation
  {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@equation}
\newcounter{figure}[chapter]
\renewcommand \thefigure
     {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@figure}
\def\fps@figure{!tbh}%原为tbp
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename\nobreakspace\thefigure}
\newenvironment{figure}
               {\@float{figure}}
               {\end@float}
\newenvironment{figure*}
               {\@dblfloat{figure}}
               {\end@dblfloat}
\newcounter{table}[chapter]
\renewcommand \thetable
     {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@table}
\def\fps@table{!htb}%原为tbp
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename\nobreakspace\thetable}
\newenvironment{table}
               {\setlength\belowcaptionskip{0.5\baselineskip}\@float{table}\zihao{5}}
               {\end@float\setlength\belowcaptionskip{0pt}}
\newenvironment{table*}
               {\setlength\belowcaptionskip{0.5\baselineskip}\@dblfloat{table}\zihao{5}}
               {\end@dblfloat\setlength\belowcaptionskip{0pt}}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{0\p@}
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{#1: #2}%
  \ifdim \wd\@tempboxa >\hsize
    #1: #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}
\newcommand\@pnumwidth{1.55em}
\newcommand\@tocrmarg{2.55em}
\newcommand\@dotsep{4.5}
\setcounter{tocdepth}{2}
\newcommand\tableofcontents{%
    \if@openright\cleardoublepage\fi
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \if@XJTUtoc@toc
%        \newaddcontentsline{toc}{part}{\contentsname}
        \newaddcontentsline{toc}{chapter}{\contentsname}
    \fi
    \chapter*{\contentsname}
        \@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}%
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    }
\newcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \setlength\@tempdima{3em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      {\leavevmode
       \large \bfseries #1\hfil \hb@xt@\@pnumwidth{\hss #2}}\par
       \nobreak
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}%
    \endgroup
  \fi}
\newcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
\newcommand*\l@section{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand*\l@subsection{\@dottedtocline{2}{3.8em}{3.2em}}
\newcommand*\l@subsubsection{\@dottedtocline{3}{7.0em}{4.1em}}
\newcommand*\l@paragraph{\@dottedtocline{4}{10em}{5em}}
\newcommand*\l@subparagraph{\@dottedtocline{5}{12em}{6em}}
\newcommand\listoffigures{%
%    \if@openright\cleardoublepage\fi
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \if@XJTUextendedtoc
        \XJTUstarchapter{\listfigurename}
    \else
        \chapter*{\listfigurename}%
    \fi
      \@mkboth{\MakeUppercase\listfigurename}{\MakeUppercase\listfigurename}%
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
    }
\newcommand*\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand\listoftables{%
%    \if@openright\cleardoublepage\fi
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \if@XJTUextendedtoc
        \XJTUstarchapter{\listtablename}%
    \else
        \chapter*{\listtablename}%
    \fi
      \@mkboth{\MakeUppercase\listtablename}{\MakeUppercase\listtablename}%
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
    }
\let\l@table\l@figure
\newdimen\bibindent
\setlength\bibindent{1.5em}
\newenvironment{thebibliography}[1]
     {\chapter*{\bibname}%
      \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
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
\newcommand\newblock{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty
\newenvironment{theindex}
               {\if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \columnseprule \z@
                \columnsep 35\p@
                \twocolumn[\@makeschapterhead{\indexname}]%
                \@mkboth{\MakeUppercase\indexname}{\MakeUppercase\indexname}
                \thispagestyle{plain}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \let\item\@idxitem}
               {\if@restonecol\onecolumn\else\clearpage\fi}
\newcommand\@idxitem{\par\hangindent 40\p@}
\newcommand\subitem{\@idxitem \hspace*{20\p@}}
\newcommand\subsubitem{\@idxitem \hspace*{30\p@}}
\newcommand\indexspace{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}
\renewcommand\footnoterule{%
  \kern-3\p@
  \hrule\@width.4\columnwidth
  \kern2.6\p@}
\renewcommand \thefootnote {\@fnsymbol\c@footnote}
\@addtoreset{footnote}{page}
\newcommand\@makefntext[1]{%
    \parindent 1em%
    \noindent
    \hb@xt@1.8em{\hss\@makefnmark}#1}
\newcommand\contentsname{Table of Contents}
\newcommand\listfigurename{List of Figures}
\newcommand\listtablename{List of Tables}
\newcommand\bibname{Bibliography}
\newcommand\indexname{Index}
\newcommand\figurename{Figure}
\newcommand\tablename{Table}
\newcommand\partname{Part}
\newcommand\chaptername{Chapter}
\newcommand\appendixname{Appendix}
\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}
\pagenumbering{arabic}
\if@XJTU@twoside%\if@twoside
\else
  \raggedbottom
\fi
\if@twocolumn
  \twocolumn
  \sloppy
  \flushbottom
\else
  \onecolumn
  \if@XJTUsloppy
    \sloppy %解决中英文混排的断行问题，会加入间距，但不会影响断行（否则当字号很大时，TeX不能很好地断行）
  \fi
\fi

% 打开首行缩进
\if@XJTU@indentfirst
    \let\@afterindentfalse\@afterindenttrue
    \@afterindenttrue
\else
    \renewcommand\indent\@afterindenttrue
\fi

%===========================================================
%%%%%%%%%%%以下部分为宏包和相关命令支持宏包%%%%%%%%%%%%%%%%%
%===========================================================
%条件判断支持宏包
\RequirePackage{ifthen}
\newcommand\XJTU@maxlength[3]{%
\ifthenelse{\lengthtest{#1 > #2}}{\setlength{#3}{#1}}{\setlength{#3}{#2}}}
\newcommand\XJTU@iszero[3]{%
\ifthenelse{\lengthtest{#1 = 0cm}}{#2}{#3}}

%长度运算支持宏包
\RequirePackage{calc}
%ifpdf宏包用于支持\ifpdf命令，判断是否当前操作为pdftex
\RequirePackage{ifpdf}
\newlength\XJTU@left
\newlength\XJTU@right
\newlength\XJTU@top
\newlength\XJTU@bottom
\newlength\XJTU@binding
\iffalse
    \setlength\XJTU@left{2.5cm}
    \setlength\XJTU@right{2.2cm}
    \setlength\XJTU@top{2.8cm}
    \setlength\XJTU@bottom{2.5cm}
    \setlength\XJTU@binding{0.5cm}
\fi
\newcommand\setpagemargins[5][0.5cm]{%
\setlength\XJTU@binding{#1}
\setlength\XJTU@left{#2}
\setlength\XJTU@right{#3}
\setlength\XJTU@top{#4}
\setlength\XJTU@bottom{#5}
\if@XJTU@realsixteenkai\else
    \addtolength\XJTU@left{5.5mm+0.5\XJTU@binding}
    \addtolength\XJTU@right{5.5mm+0.5\XJTU@binding}
    \addtolength\XJTU@top{5mm}
    \addtolength\XJTU@bottom{5mm}
\fi
\XJTU@setmargins}
%仅当\setcovermargins命令未执行过的情况下重置页面布局
%否则会覆盖已经声明的封面页面布局
%\if@XJTU@covermarginschanged\else
%\XJTU@setmargins\fi}%设置页边距
\setlength{\headsep}{20pt}
\setlength{\headheight}{1.5\baselineskip}
\newcommand\setheadlengths[2]{%
\setlength{\headheight}{#1}
\setlength{\headsep}{#2}
\XJTU@setmargins}%设置页眉高度及页眉和正文的垂直间距
\newcommand{\XJTU@setmargins}{%
\ifpdf
%设置pdf页面尺寸，摘自Jinhua的例子程序
%关掉这部分代码似乎pdflatex也可以正常生成pdf
    \setlength{\pdfpagewidth}{\paperwidth}
    \setlength{\pdfpageheight}{\paperheight}
    \setlength{\pdfvorigin}{1in}
    \setlength{\pdfhorigin}{1in}
\fi
\setlength{\textwidth}{\paperwidth-\XJTU@left-\XJTU@right}
\setlength{\oddsidemargin}{\XJTU@left}
\if@XJTU@twoside%\if@twoside
    \addtolength{\textwidth}{-\XJTU@binding}
    \addtolength{\oddsidemargin}{\XJTU@binding}
    \setlength{\evensidemargin}{\XJTU@right}
\else
    \setlength{\evensidemargin}{\oddsidemargin}
\fi
\addtolength{\oddsidemargin}{-1in}
\addtolength{\evensidemargin}{-1in}
\setlength{\textheight}{\paperheight-\XJTU@top-\XJTU@bottom}
\setlength{\topmargin}{\XJTU@top-\headheight-\headsep-1in}}
\setpagemargins{2.5cm}{2.2cm}{2.8cm}{2.5cm}%初始化页面布局
%\XJTU@setmargins
  
%中文支持宏包，部分命令在xjtu_GB.cpx中定义
\RequirePackage{CJK}
\RequirePackage{CJKnumb}
%\RequirePackage{ulem}
%\RequirePackage{CJKulem}
\newcommand\bCJKstar[1]{\begin{CJK*}{GBK}{#1}}
\newcommand\bCJKnostar[1]{\begin{CJK}{GBK}{#1}}
\newcommand\bCJK{\@ifstar{\bCJKstar}{\bCJKnostar}}%\@ifstar不支持带参数的命令，只能转向其他命令
\newcommand\eCJK{\clearpage\@ifstar{\end{CJK*}}{\end{CJK}}}
\newcommand\song{\CJKfamily{\XJTU@initialCJKfamily}}
\newcommand\kai{\CJKfamily{kai}}
%\newcommand\hei{\CJKfamily{hei}}
\newcommand\hei{\song}
\newcommand\fs{\CJKfamily{fs}}
\newcommand\li{\CJKfamily{li}}
\newcommand\you{\CJKfamily{you}}
\newlength\XJTU@CJKglue
\setlength\XJTU@CJKglue{0pt}
\newcommand\ziju[1]{%字距，摘自cxterm的cjkctex.sty，使用\ziju{0pt}恢复缺省字距
\setlength\XJTU@CJKglue{#1}%
\renewcommand{\CJKglue}{\hskip #1 \@plus .08\baselineskip}}
\newlength\XJTU@wideChinese
\newcommand\WideChinesei[2]{%
\setlength\XJTU@wideChinese{#1\ccwd + #1\XJTU@CJKglue - \XJTU@CJKglue}%
\makebox[\XJTU@wideChinese][s]{#2}}
\newcommand\WideChineseii[2]{%
\settowidth\XJTU@wideChinese{#1}%
\makebox[\XJTU@wideChinese][s]{#2}}
\newcommand\WideChinese{\@ifstar{\WideChineseii}{\WideChinesei}}
%字号及相关命令，来自cxterm的cjkctex.sty
\newdimen\ccwd % 字宽，注意在切换字体大小后应重新调用 \CJKindent 以确保得到正确的字宽。
\newlength\CJKtwospaces
\renewcommand\CJKindent{\setbox\CJK@indent\hbox{\CJK@spaceChar\CJKglue\CJK@spaceChar}%
\parindent\wd\CJK@indent\ccwd=.5\wd\CJK@indent\setlength\CJKtwospaces{\wd\CJK@indent}} %段首缩进 2 个中文字的距离。
\newdimen\bp@  \bp@=1bp % 字体定义中使用 PS 磅值。 1 in = 72 bp = 72.27 pt
\def\@cjk@normaleightbp{5}    \def\@cjk@normaleightskip{7}   %八号字
\def\@cjk@normalsevenbp{5.5}  \def\@cjk@normalsevenskip{8}   %七号字  
\def\@cjk@smallsixbp{6.5}     \def\@cjk@smallsixskip{9}      %小六号  
\def\@cjk@normalsixbp{7.5}    \def\@cjk@normalsixskip{10.5}  %六号字  
\def\@cjk@smallfivebp{9}      \def\@cjk@smallfiveskip{13.5}  %小五号  
\def\@cjk@normalfivebp{10.5}  \def\@cjk@normalfiveskip{15}   %五号字  
\def\@cjk@smallfourbp{12}     \def\@cjk@smallfourskip{17}    %小四号  
\def\@cjk@normalfourbp{14}    \def\@cjk@normalfourskip{19.5} %四号字  
\def\@cjk@smallthreebp{15}    \def\@cjk@smallthreeskip{21}   %小三号  
\def\@cjk@normalthreebp{16}   \def\@cjk@normalthreeskip{22.5}%三号字  
\def\@cjk@smalltwobp{18}      \def\@cjk@smalltwoskip{25}     %小二号  
\def\@cjk@normaltwobp{22}     \def\@cjk@normaltwoskip{31}    %二号字  
\def\@cjk@smallonebp{24}      \def\@cjk@smalloneskip{33}     %小一号  
\def\@cjk@normalonebp{26}     \def\@cjk@normaloneskip{36}    %一号字  
\def\@cjk@smallzerobp{36}     \def\@cjk@smallzeroskip{48}    %小初号  
\def\@cjk@normalzerobp{42}    \def\@cjk@normalzeroskip{56}   %初号字  
\newcount\CJK@ZihaoNo
%\newcommand\defCJKindent{\if@XJTUcontrolindent\CJKindent\fi}
\def\defCJKfontsize#1#2#3#4{%
        \fontsize{#1\bp@}{#2pt plus#3pt minus #4pt}\selectfont\if@XJTUcontrolindent\CJKindent\else\fi}
\def\zihao#1{\CJK@ZihaoNo=#1 %该命令会在命令调用的当前位置引入多余的空格，在所有的回车前加“%”问题解决
             \ifnum #11<0%
                        \ifnum \CJK@ZihaoNo=-0  \defCJKfontsize\@cjk@smallzerobp\@cjk@smallzeroskip{.5}{.3}%
                   \else\ifnum \CJK@ZihaoNo=-1  \defCJKfontsize\@cjk@smallonebp\@cjk@smalloneskip{.5}{.3}%
                   \else\ifnum \CJK@ZihaoNo=-2  \defCJKfontsize\@cjk@smalltwobp\@cjk@smalltwoskip{.3}{.2}%
                   \else\ifnum \CJK@ZihaoNo=-3  \defCJKfontsize\@cjk@smallthreebp\@cjk@smallthreeskip{.3}{.2}%
                   \else\ifnum \CJK@ZihaoNo=-4  \defCJKfontsize\@cjk@smallfourbp\@cjk@smallfourskip{.3}{.2}%
                   \else\ifnum \CJK@ZihaoNo=-5  \defCJKfontsize\@cjk@smallfivebp\@cjk@smallfiveskip{.2}{.1}%
                   \else\ifnum \CJK@ZihaoNo=-6  \defCJKfontsize\@cjk@smallsixbp\@cjk@smallsixskip{.2}{.1}%
                   \fi\fi\fi\fi\fi\fi\fi
             \else%
                        \ifnum \CJK@ZihaoNo=0   \defCJKfontsize\@cjk@normalzerobp\@cjk@normalzeroskip{.5}{.3}%
                   \else\ifnum \CJK@ZihaoNo=1   \defCJKfontsize\@cjk@normalonebp\@cjk@normaloneskip{.5}{.3}%
                   \else\ifnum \CJK@ZihaoNo=2   \defCJKfontsize\@cjk@normaltwobp\@cjk@normaltwoskip{.5}{.3}%
                   \else\ifnum \CJK@ZihaoNo=3   \defCJKfontsize\@cjk@normalthreebp\@cjk@normalthreeskip{.3}{.2}%
                   \else\ifnum \CJK@ZihaoNo=4   \defCJKfontsize\@cjk@normalfourbp\@cjk@normalfourskip{.3}{.2}%
                   \else\ifnum \CJK@ZihaoNo=5   \defCJKfontsize\@cjk@normalfivebp\@cjk@normalfiveskip{.3}{.2}%
                   \else\ifnum \CJK@ZihaoNo=6   \defCJKfontsize\@cjk@normalsixbp\@cjk@normalsixskip{.2}{.1}%
                   \else\ifnum \CJK@ZihaoNo=7   \defCJKfontsize\@cjk@normalsevenbp\@cjk@normalsevenskip{.1}{.1}%
                   \else\ifnum \CJK@ZihaoNo=8   \defCJKfontsize\@cjk@normaleightbp\@cjk@normaleightskip{.1}{.1}%
                   \fi\fi\fi\fi\fi\fi\fi\fi\fi
            \fi}
\def\XJTU@defCJKfontsize#1#2#3#4{%
        \fontsize{#1}{#2 plus#3pt minus #4pt}\selectfont\if@XJTUcontrolindent\CJKindent\else\fi}
\newlength\XJTU@ZiHaosize
\newcommand\ZiHao[2][1.33]{%
\setlength\XJTU@ZiHaosize{#2\bp@}%
\XJTU@defCJKfontsize{\XJTU@ZiHaosize}{#1\XJTU@ZiHaosize}{.5}{.3}}%模仿Word中定义任意尺寸的字号
\if@XJTUnewgbkfonts
\newcommand\XJTU@initialCJKfamily{xjtu}
\else
\newcommand\XJTU@initialCJKfamily{song}
\fi
\if@XJTU@cjkspace
   \AtBeginDocument{\if@XJTUcaphead\else\let\MakeUppercase\relax\fi\bCJK{\XJTU@initialCJKfamily}\CJKcaption{xjtu_GB}}
   \AtEndDocument{\eCJK}
   \if@XJTU@cjktilde
      \AtBeginDocument{\CJKtilde}
   \else
   \fi
\else
   \AtBeginDocument{\if@XJTUcaphead\else\let\MakeUppercase\relax\fi\bCJK*{\XJTU@initialCJKfamily}\CJKcaption{xjtu_GB}}
   \AtEndDocument{\eCJK*}
\fi
\AtBeginDocument{\CJKindent}
%使用小四和五号为当前标准字体时设置各级字体和环境尺寸，摘自cxterm的cjkbook.cls
\if@XJTU@cjksmallfour
   \renewcommand\normalsize{%
      \@setfontsize\normalsize{\@cjk@smallfourbp\bp@}\@cjk@smallfourskip%
      \abovedisplayskip 12.5\p@ \@plus3\p@ \@minus7\p@
      \abovedisplayshortskip \z@ \@plus3\p@
      \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
      \belowdisplayskip \abovedisplayskip
      \let\@listi\@listI}
   \normalsize
   \renewcommand\small{%
      \@setfontsize\small{\@cjk@normalfivebp\bp@}\@cjk@normalfiveskip%
      \abovedisplayskip 11\p@ \@plus3\p@ \@minus6\p@
      \abovedisplayshortskip \z@ \@plus3\p@
      \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
      \def\@listi{\leftmargin\leftmargini
                  \topsep 9\p@ \@plus3\p@ \@minus5\p@
                  \parsep 4.5\p@ \@plus2\p@ \@minus\p@
                  \itemsep \parsep}%
      \belowdisplayskip \abovedisplayskip}
   \renewcommand\footnotesize{%
      \@setfontsize\footnotesize{\@cjk@smallfivebp\bp@}\@cjk@smallfiveskip%
      \abovedisplayskip 9.5\p@ \@plus2\p@ \@minus5\p@
      \abovedisplayshortskip \z@ \@plus3\p@
      \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
      \def\@listi{\leftmargin\leftmargini
                  \topsep 6\p@ \@plus2\p@ \@minus2\p@
                  \parsep 3\p@ \@plus2\p@ \@minus\p@
                  \itemsep \parsep}%
      \belowdisplayskip \abovedisplayskip}
   \renewcommand\large{\@setfontsize\large{\@cjk@normalfourbp\bp@}\@cjk@normalfourskip}
   \renewcommand\Large{\@setfontsize\Large{\@cjk@normalthreebp\bp@}\@cjk@normalthreeskip}
   \renewcommand\LARGE{\@setfontsize\LARGE{\@cjk@normaltwobp\bp@}\@cjk@normaltwoskip}
   \renewcommand\huge{\@setfontsize\huge{\@cjk@normalonebp\bp@}\@cjk@normaloneskip}
   \renewcommand\Huge{\@setfontsize\Huge{\@cjk@smallzerobp\bp@}\@cjk@smallzeroskip}
\fi
\if@XJTU@cjknormalfive
   \renewcommand\normalsize{%
      \@setfontsize\normalsize{\@cjk@normalfivebp\bp@}\@cjk@normalfiveskip%
      \abovedisplayskip 11.5\p@ \@plus3\p@ \@minus6\p@
      \abovedisplayshortskip \z@ \@plus3\p@
      \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
      \belowdisplayskip \abovedisplayskip
      \let\@listi\@listI}
   \normalsize
   \renewcommand\small{%
      \@setfontsize\small{\@cjk@smallfivebp\bp@}\@cjk@smallfiveskip
      \abovedisplayskip 10.5\p@ \@plus2\p@ \@minus5\p@
      \abovedisplayshortskip \z@ \@plus3\p@
      \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
      \def\@listi{\leftmargin\leftmargini
                  \topsep 6\p@ \@plus2\p@ \@minus2\p@
                  \parsep 3\p@ \@plus2\p@ \@minus\p@
                  \itemsep \parsep}%
      \belowdisplayskip \abovedisplayskip
   }
   \renewcommand\scriptsize{\@setfontsize\scriptsize{\@cjk@normalsixbp\bp@}\@cjk@normalsixskip}
   \renewcommand\tiny{\@setfontsize\tiny{\@cjk@smallsixbp\bp@}\@cjk@smallsixskip}
   \renewcommand\large{\@setfontsize\large{\@cjk@smallfourbp\bp@}\@cjk@smallfourskip}
   \renewcommand\Large{\@setfontsize\Large{\@cjk@smallthreebp\bp@}\@cjk@smallthreeskip}
   \renewcommand\LARGE{\@setfontsize\LARGE{\@cjk@smalltwobp\bp@}\@cjk@smalltwoskip}
   \renewcommand\huge{\@setfontsize\huge{\@cjk@smallonebp\bp@}\@cjk@smalloneskip}
   \renewcommand\Huge{\@setfontsize\Huge{\@cjk@smallzerobp\bp@}\@cjk@smallzeroskip}
\fi

% 颜色支持宏包
\RequirePackage{color}
\definecolor{webred}{rgb}{0.3,0,0}
\definecolor{webblue}{rgb}{0,0,0.7}
\definecolor{webgreen}{rgb}{0,0.4,0}

%超级链接和引用支持宏包，为避免兼容性问题，hyperref放在这个位置
%放在所有宏包的后面对6.47h版本的hyperref会发生编译错误
%unicode option cannot work with CJK bookmarks
\ifpdf
    % 转换为pdf文件时自动加入索引, 用pdftex 编译。
    \RequirePackage[pdftex,CJKbookmarks=true,\if@XJTU@pdfunicode unicode=true,\else unicode=false,\fi%
    \if@XJTU@bookmarksnumbered bookmarksnumbered=true,\else bookmarksnumbered=false,\fi%
    \if@XJTU@bookmarksopen bookmarksopen=true,\else bookmarksopen=false,\fi%
    colorlinks=true,%
    \if@XJTUhardcopy%
        linkcolor=black,citecolor=black,anchorcolor=black,urlcolor=black%
    \else%
        linkcolor=webred,citecolor=webblue,anchorcolor=webgreen,urlcolor=webblue%
    \fi
    ]{hyperref}%
\else
    \if@XJTUdvipdfm
        % 转换为pdf文件时自动加入索引, 用latex+dvipdfmx编译。
        \RequirePackage[dvipdfm,CJKbookmarks=true,\if@XJTU@pdfunicode unicode=true,\else unicode=false,\fi%
        \if@XJTU@bookmarksnumbered bookmarksnumbered=true,\else bookmarksnumbered=false,\fi%
        \if@XJTU@bookmarksopen bookmarksopen=true,\else bookmarksopen=false,\fi%
        colorlinks=true,%
        \if@XJTUhardcopy%
            linkcolor=black,citecolor=black,anchorcolor=black,urlcolor=black%
        \else%
            linkcolor=webred,citecolor=webblue,anchorcolor=webgreen,urlcolor=webblue%
        \fi
        ]{hyperref}%
        %以下代码用于在dvipdfm模式下支持中文书签
        \AtBeginDvi{\special{pdf:tounicode GBK-EUC-UCS2}}
    \else
        \if@XJTUdvips
            %转换为pdf文件时自动加入索引, 用latex+dvips编译，会造成toc和URL不自动折行！！
            \RequirePackage[dvips,CJKbookmarks=true,\if@XJTU@pdfunicode unicode=true,\else unicode=false,\fi%
            \if@XJTU@bookmarksnumbered bookmarksnumbered=true,\else bookmarksnumbered=false,\fi%
            \if@XJTU@bookmarksopen bookmarksopen=true,\else bookmarksopen=false,\fi%
            colorlinks=true,%
            \if@XJTUhardcopy%
                linkcolor=black,citecolor=black,anchorcolor=black,urlcolor=black%
            \else%
                linkcolor=webred,citecolor=webblue,anchorcolor=webgreen,urlcolor=webblue%
            \fi
            ]{hyperref}%
        \else
            \RequirePackage[CJKbookmarks=true,\if@XJTU@pdfunicode unicode=true,\else unicode=false,\fi%
            \if@XJTU@bookmarksnumbered bookmarksnumbered=true,\else bookmarksnumbered=false,\fi%
            \if@XJTU@bookmarksopen bookmarksopen=true,\else bookmarksopen=false,\fi%
            colorlinks=true,%
            \if@XJTUhardcopy%
                linkcolor=black,citecolor=black,anchorcolor=black,urlcolor=black%
            \else%
                linkcolor=webred,citecolor=webblue,anchorcolor=webgreen,urlcolor=webblue%
            \fi
            ]{hyperref}%
        \fi
    \fi
\fi
%据shredder测试，下列代码和CJKbookmarks=true具有同等效果
\iffalse
\pdfstringdefDisableCommands{
\let\CJK@XX\relax
\let\CJK@XXX\relax
\let\CJK@XXXp\relax
\let\CJK@XXXX\relax
\let\CJK@XXXXp\relax}
\fi
%扩展书签模式支持，随hyperref提供，但是可以单独使用
\RequirePackage{hypbmsec}
%为定义一个扩展的\addcontentsline命令以更好的支持hyperref
\newcommand\newaddcontentsline[3]{\phantomsection\addcontentsline{#1}{#2}{#3}}

%图形支持宏包
\ifpdf
\RequirePackage[pdftex]{graphicx}
\else
\@ifundefined{XJTU@dvips}{%
\RequirePackage{graphicx}}
{\RequirePackage[dvips]{graphicx}}
\fi
\RequirePackage{psfrag}
%\graphicspath{{figures/}}

%参考文献样式支持宏包
\RequirePackage[numbers,sort&compress]{natbib}
\RequirePackage{hypernat}
\let\ncite\cite
\if@XJTU@supercite
    \renewcommand\cite[2][]{\textsuperscript{\ncite[#1]{#2}}}
\fi
\newcommand\scite[2][]{\textsuperscript{\ncite[#1]{#2}}}

%使用tocbibind宏包不能解决参考文献无法进入目录的问题（造成multibib的序号复位功能失效）
%另外，使用\mynewcite引入新的参考文献列表时，如果使用\section*则会被tocbibind屏蔽掉
%因此，重定义natbib的\bibsection命令以解决这个问题
%下面引入一个新的定义\XJTUstarchapter替代\chapter*以支持在加入目录
%将\newaddcontentsline{toc}{chapter}{\bibname}放入\chapter*
%实现正确目录条目定位的办法是一个hack的办法
%欢迎有更好的解决办法的朋友提供信息，谢谢
\newcommand\XJTUstarchapter[1]{\chapter*{\newaddcontentsline{toc}{chapter}{#1}#1}}
\newcommand\XJTU@bibchapter{%
\renewcommand\bibsection{%
\if@openright\cleardoublepage\fi%
\XJTUstarchapter{\bibname}%
\markboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}}}
\newcommand\XJTU@bibsection{%
\renewcommand\bibsection{%
\newaddcontentsline{toc}{chapter}{\bibname}%
\section*{\bibname}%
\markboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}}}
\XJTU@bibchapter%设置参考文献进入目录

%多文档支持宏包，xjtu_mbib系由multibib改造而来
\RequirePackage{xjtu_mbib}
\newcommand\mypub[3]{%
\XJTU@bibchapter%设置参考文献进入目录
\newcites{mypub}{#1}
\renewcommand\bibname{#1}
\nocitemypub{*}
\bibliographystylemypub{#2}
\bibliographymypub{#3}}%攻读博士学位期间发表的相关论文列表
\newcommand\mynewcite[5][section]{
\ifthenelse{\equal{#1}{section}}{\XJTU@bibsection}{\XJTU@bibchapter}
\newcites{#2}{#3}\renewcommand\bibname{#3}
\csname nocite#2\endcsname{*}
\csname bibliographystyle#2\endcsname{#4}
\csname bibliography#2\endcsname{#5}}%其他论文列表

%数学支持宏包
\RequirePackage{amsmath}
\RequirePackage{bm}
\RequirePackage[amsmath,thmmarks]{ntheorem}
\RequirePackage{mathrsfs}
\RequirePackage{amssymb}
\allowdisplaybreaks[4]
\theoremstyle{plain} \theorembodyfont{\it} \theoremheaderfont{\bf}
\theoremseparator{:}
\if@XJTUenglishthesis
    \newtheorem{definition}{\bf Definition}[chapter]
    \newtheorem{proposition}{\bf Proposition}[chapter]
    \newtheorem{lemma}{\bf Lemma}[chapter]
    \newtheorem{theorem}{\bf Theorem}[chapter]
    \newtheorem{axiom}{\bf Axiom}[chapter]
    \newtheorem{corollary}{\bf Corollary}[chapter]
    \newtheorem{exercise}{\bf Exercise}[chapter]
    \newtheorem{remark}{\bf Remark}[chapter]
    \newtheorem{example}{\bf Example}
    \newenvironment{proof}{\noindent\textit{Proof}: }{\hfill$\blacksquare$\vskip 0.5\baselineskip}
\fi
\newtheorem{edefinition}{\bf Definition}[chapter]
\newtheorem{eproposition}{\bf Proposition}[chapter]
\newtheorem{elemma}{\bf Lemma}[chapter]
\newtheorem{etheorem}{\bf Theorem}[chapter]
\newtheorem{eaxiom}{\bf Axiom}[chapter]
\newtheorem{ecorollary}{\bf Corollary}[chapter]
\newtheorem{eexercise}{\bf Exercise}[chapter]
\newtheorem{eremark}{\bf Remark}[chapter]
\newtheorem{eexample}{\bf Example}
\newenvironment{eproof}{\noindent\textit{Proof}: }{\hfill$\blacksquare$\vskip 0.5\baselineskip}

%表格列宽自动计算支持宏包
%\RequirePackage{tabularx}
%\RequirePackage{mdwtab}

% 表格标题重定义支持宏包
\RequirePackage{ccaption}
%\captionwidth{0.8\textwidth}
%\changecaptionwidth
%重定义表格标题宽度的命令
\newcommand\setcapwidth[1]{\captionwidth{#1}\changecaptionwidth}
\captionstyle{\centering}
\captionnamefont{\bfseries}
%\renewcommand{\fnum@figure}[1]{\textbf{\figurename~\thefigure. }}

\if@XJTU@moresections
    %如果目录中为节号和小节号留的空间太小而与标题重叠
    %请使用如下代码增大空间，只需修改其中的两个长度值
    %两个长度的具体意义请参考titletoc宏包说明
    \RequirePackage{titletoc}
    \dottedcontents{section}[4.2em]{}{3em}{1pc}
    \dottedcontents{subsection}[6.2em]{}{4em}{1pc}
\fi

%===========================================================
%%%%%%%%%%%%%%%%%以下部分为自定义命令%%%%%%%%%%%%%%%%%%%%%%%
%===========================================================

%博士论文相关信息设置命令
%英文作者名和标题由LaTeX2e内部定义\author, \title
\newcommand\XJTU@cauthor{}
\newcommand\cauthor[1]{\renewcommand\XJTU@cauthor{#1}}%中文作者
\newcommand\XJTU@ctitle{}
\newcommand\ctitle[1]{\renewcommand\XJTU@ctitle{#1}}%中文标题
\newcommand\XJTU@major{}
\newcommand\major[1]{\renewcommand\XJTU@major{#1}}%英文专业名
\newcommand\XJTU@cmajor{}
\newcommand\cmajor[1]{\renewcommand\XJTU@cmajor{#1}}%中文专业名
\newcommand\XJTU@research{}
\newcommand\research[1]{\renewcommand\XJTU@research{#1}}%英文研究方向
\newcommand\XJTU@cresearch{}
\newcommand\cresearch[1]{\renewcommand\XJTU@cresearch{#1}}%中文研究方向
\newcommand\XJTU@researchtype{}
\newcommand\researchtype[1]{\renewcommand\XJTU@researchtype{#1}}%英文研究类型
\newcommand\XJTU@cresearchtype{}
\newcommand\cresearchtype[1]{\renewcommand\XJTU@cresearchtype{#1}}%中文研究类型
\newcommand\XJTU@teacheri{}
\newcommand\XJTU@professori{}
\newcommand\teacher[2][Prof.]{%
\renewcommand\XJTU@teacheri{#2}
\renewcommand\XJTU@professori{#1}}%英文第一指导教师姓名与职称
\newcommand\XJTU@cteacheri{}
\newcommand\XJTU@cprofessori{}%中文第一指导教师姓名与职称，设置命令参见xjtu_GB.cpx
\newif\if@XJTUteacherii\@XJTUteacheriifalse
\newcommand\XJTU@teacherii{}
\newcommand\XJTU@professorii{}
\newcommand\teacherii[2][Professor]{%
\renewcommand\XJTU@teacherii{#2}
\renewcommand\XJTU@professorii{#1}
\@XJTUteacheriitrue}%英文第二指导教师姓名与职称
\newif\if@XJTUcteacherii\@XJTUcteacheriifalse
\newcommand\XJTU@cteacherii{}
\newcommand\XJTU@cprofessorii{}%中文第二指导教师姓名与职称，设置命令参见xjtu_GB.cpx
\newcommand\XJTU@school{Xi'an Jiaotong University}
\newcommand\XJTU@cschool{}
\newcommand\school[2]{
\renewcommand\XJTU@school{#1}
\renewcommand\XJTU@cschool{#2}}%英文/中文学校名称
\newcommand\XJTU@schoolii{Xi'an Jiaotong University}
\newcommand\XJTU@cschoolii{}
\newcommand\schoolii[2]{
\renewcommand\XJTU@schoolii{#1}
\renewcommand\XJTU@cschoolii{#2}}%副导师所在学校的英文/中文名称
\newcommand\XJTU@catID{}
\newcommand\catID[1]{\renewcommand\XJTU@catID{#1}}%中图分类号
\newcommand\XJTU@security{}
\newcommand\security[1]{\renewcommand\XJTU@security{#1}}%密级
\newcommand\XJTU@UDC{}
\newcommand\UDC[1]{\renewcommand\XJTU@UDC{#1}}%UDC is what?
\newcommand\XJTU@datesubmitted{}
\newcommand\datesubmitted[1]{\renewcommand\XJTU@datesubmitted{#1}}%论文提交日期（英文）
\newcommand\XJTU@cdatesubmitted{}
\newcommand\cdatesubmitted[1]{\renewcommand\XJTU@cdatesubmitted{#1}}%论文提交日期
\newcommand\XJTU@cdatelastupdated{}
\newcommand\cdatelastupdated[1]{\renewcommand\XJTU@cdatelastupdated{#1}}%论文最后修正日期
\newcommand\XJTU@datedefense{}
\newcommand\datedefense[1]{\renewcommand\XJTU@datedefense{#1}}%论文答辩日期（英文）
\newcommand\XJTU@cdatedefense{}
\newcommand\cdatedefense[1]{\renewcommand\XJTU@cdatedefense{#1}}%论文答辩日期
\iffalse
    \newcommand\XJTU@defensechair{}
    \newcommand\XJTU@cdefensechair{}
    \newcommand\defensechair[2][null]{
    \renewcommand\XJTU@defensechair{#1}
    \renewcommand\XJTU@cdefensechair{#2}}%论文答辩委员会主席英中文姓名
    \newcommand\XJTU@reviewers{}
    \newcommand\XJTU@creviewers{}
    \newcommand\reviews[2][null]{
    \renewcommand\XJTU@reviewers{#1}
    \renewcommand\XJTU@creviewers{#2}}%论文评阅人名单（英中文）
\fi
\newcommand\XJTU@schoollogo{XJTU}
\newlength\XJTU@schoollogowidth
\setlength\XJTU@schoollogowidth{0.4\textwidth}
\newcommand\schoollogo[2][0.4\textwidth]{%
\setlength\XJTU@schoollogowidth{#1}
\renewcommand\XJTU@schoollogo{#2}}%学校校名或者校徽logo图文件名及其宽度
\newcommand\XJTU@thesisname{}
\newcommand\thesisname[1]{\renewcommand\XJTU@thesisname{#1}}%学位论文名称
\newcommand\XJTU@degree{Ph. D.}%未用
\newcommand\XJTU@cdegree{}
\newcommand\degree[2][Ph. D.]{
\renewcommand\XJTU@degree{#1}
\renewcommand\XJTU@cdegree{#2}}%学位论文名称

%一些自定义的琐碎命令
\newcommand\LowerRoman[1]{\romannumeral#1}%小写的罗马数字
\newcommand\UpperRoman[1]{\uppercase\expandafter{\romannumeral#1}}%大写的罗马数字
\newcommand\XJTUcomments[1]{}
\newcommand\DS{\displaystyle}
%\newcommand\myfrac[2]{\frac{\DS #1}{\DS #2}}
\newcommand\myfrac[2]{\dfrac{#1}{#2}}
\newcommand\half{\myfrac{1}{2}}
\newcommand\shalf{\frac{1}{2}}
\newcommand\DPWLCM{\mathcal{F}_n}
\newlength{\figwidth}
\setlength{\figwidth}{0.6\columnwidth}
\newlength{\mpwidth}
\setlength{\mpwidth}{0.5\columnwidth}
\newlength{\sfigwidth}
\setlength{\sfigwidth}{\mpwidth}

\endinput
%%
%% End of file `xjtuthesis.cls'.
