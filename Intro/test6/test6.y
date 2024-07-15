%{
#include <stdio.h>
int yylex();
int yyerror();
%}
%token NUM
%left '+' '-'
%left '*' '/'
%%
s:	expr 		{ printf("The result is: %d\n", $1); }
expr:	expr '+' expr	{ $$ = $1 + $3; } |
	expr '-' expr	{ $$ = $1 - $3; } |
	expr '*' expr	{ $$ = $1 * $3; } |
	expr '/' expr	{ $$ = $1 / $3; } |
	NUM		{ $$ = $1; }
%%
#include "lex.yy.c"
int main()
{
	return yyparse();
}
int yyerror()
{
	printf("Syntax error\n");
	return 0;
}
