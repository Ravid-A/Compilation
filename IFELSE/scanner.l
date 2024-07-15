letter         [a-zA-Z]
digit          [0-9]
nonzero        [1-9]
char            {letter}|{digit}|"_"
indentifier      {letter}({char})*
int_literal     {nonzero}{digit}*|0

%%
[ \s\t]                         { /* ignore whitespace */ }
"if"                            { return IF; }
"else"                          { return ELSE; }

"("                             { return LPAREN; }
")"                             { return RPAREN; }

"="                             { return ASSIGN; }
";"                             { return SEMICOLON; }

"=="                            { return EQ; }
"!="                            { return NE; }
"<"                             { return LT; }
"<="                            { return LE; }
">"                             { return GT; }
">="                            { return GE; }

{indentifier}                   { return ID; }
{int_literal}                   { return INT_LIT; }

\n                             { yylineno++; }
.                              { return yytext[0]; }
%%