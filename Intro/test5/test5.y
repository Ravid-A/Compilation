%{
#include <stdio.h>
int yylex();
int yyerror();
%}
%token AUGUST SEPTEMBER OCTOBER NOVEMBER DECEMBER
%token YEAR
%%
s: month '#' YEAR
   {
	printf("%d %d\n", $1, $3);
	printf("Date is OK\n");
   }
month:	AUGUST		{ $$ = $1; } |
      	SEPTEMBER	{ $$ = $1; } |
 	OCTOBER		{ $$ = $1; } |
	NOVEMBER	{ $$ = $1; } |
	DECEMBER	{ $$ = $1; } ;
%%
#include "lex.yy.c"
int main()
{
	return yyparse();
}
int yyerror()
{
	printf("Error in date\n");
	return 0;
}
