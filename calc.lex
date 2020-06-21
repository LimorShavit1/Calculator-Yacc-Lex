 #include "y.tab.h"
 #include <math.h>
%%
[ \t] ; 

[0-9]* {
          yylval.fval = atof(yytext); 
          return NUMBER;
          }
[0-9]*[.][0-9]+ {
          yylval.fval = atof(yytext); 
          return NUMBER;
          }

sin {return SIN;}
cos {return COS;}
tan {return TAN;}
sqrt {return SQRT;}
pi   {  yylval.fval=atof(yytext); return PI; }
e    { yylval.fval=atof(yytext);  return E; }
log2 { return LOG2; }
log10 { return LOG10; }
"//"          return DEV_2; 

"**"	return POWER;
"$"	    exit(1);
\n		return yytext[0];
.		return yytext[0];
%%
