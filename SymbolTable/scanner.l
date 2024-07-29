%{
#include <string.h>
%}
%%
int { yycolumn += yyleng; return INT; }
double { yycolumn += yyleng; return DOUBLE; }
char { yycolumn += yyleng; return CHAR; }
[a-z]+[a-z0-9]* { yycolumn += yyleng; yylval.s = strdup(yytext); return ID; }
[ \s\t]+ { yycolumn += yyleng;};
\n { yylineno++; yycolumn = 0; }
. { return yytext[0]; }
%%