%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
%}

%token INT_LIT ID IF ELSE LPAREN RPAREN SEMICOLON
%left EQ NE LT LE GT GE
%right ASSIGN

%start start

%%
start: if_stmt { printf("Valid syntax\n"); } ;

stmt: if_stmt
    | other_stmt
    ;

if_stmt: IF EXPR stmt
       | IF EXPR matched_stmt ELSE stmt
;

matched_stmt: IF EXPR matched_stmt ELSE matched_stmt
            | other_stmt
;

EXPR: LPAREN expr RPAREN;

expr: value EQ value
    | value NE value
    | value LT value
    | value LE value
    | value GT value
    | value GE value
    ;

stmt_block: '{' stmt_list '}'
    ;

stmt_list: stmt_list stmt
         | stmt
         ;

other_stmt: assignment
          | stmt_block
          ;

assignment: ID ASSIGN value SEMICOLON
          ;

value: INT_LIT
     | ID
     ;

%%
#include "lex.yy.c"

int main() {
    return yyparse();
}

void yyerror(const char *s) {
    printf("Error: %s\n", s);
    printf("Error at line %d\n", yylineno);
    printf("Exiting...\n");
}
