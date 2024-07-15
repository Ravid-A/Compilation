%{
    #include <string.h>    
%}

digit [0-9]
nonzero_digit [1-9]
letter [a-zA-Z]
character [a-zA-Z0-9]

int_literal 0|{nonzero_digit}{digit}*
real_literal {int_literal}\.{digit}+
char_literal '{character}'

identifier {letter}({character}|_)*


%%
"function" { return FUNCTION; }
"return" { return RETURN; }

"char" { return CHAR; }
"int" { return INT;  }
"real" { return REAL; }

"void" { return VOID; }

{int_literal} { yylval.ival = atoi(yytext); return INT_LITERAL; }
{real_literal} { yylval.rval = atof(yytext); return REAL_LITERAL; }
{char_literal} { yylval.cval = yytext[0]; return CHAR_LITERAL; }

{identifier} { return IDENTIFIER; }

"(" { return LPAREN; }
")" { return RPAREN; }

"{" { return LBRACE; }
"}" { return RBRACE; }

";" { return SEMICOLON; }
"," { return COMMA; }

"=" { return ASSIGN; }

[ \t\s] { /* ignore whitespace */ }
[ \n] { yylineno++; }
. { return yytext[0];   }
%%