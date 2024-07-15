%{
#include <stdio.h>
int yylex();
int yyerror();
%}
%token IF ELSE CONTINUE CASE BREAK DEFAULT FOR DO WHILE
%%
S: S | STATEMENTS;
STATEMENTS: IF_STATEMENTS	{ printf("Parsed conditional statement\n"); } |
	    LOOP_STATEMENTS	{ printf("Parsed loop statement\n"); } ;
IF_STATEMENTS: IF_ST | SWITCH_ST;
LOOP_STATEMENTS: FOR_ST | WHILE_ST;
IF_ST: IF | ELSE;
SWITCH_ST: CASE | BREAK | DEFAULT;
FOR_ST: FOR | CONTINUE;
WHILE_ST: DO | WHILE;
%%
#include "lex.yy.c"
int main()
{
	return yyparse();
}
int yyerror()
{
	printf("Error in C statement\n");
	return 0;
}
