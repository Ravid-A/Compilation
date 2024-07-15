%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    void yyerror(const char *s);
    int yylex(void);

    // typedef enum {
    //     TYPE_CHAR,
    //     TYPE_INT,
    //     TYPE_REAL,
    //     TYPE_VOID
    // } returnType;

    // returnType currentFunctionReturnType;

    int flag = 0;
%}

%union {
    char *sval;
    int ival;
    float rval;
    char cval;
}

%token <ival> INT_LITERAL
%token <rval> REAL_LITERAL
%token <cval> CHAR_LITERAL

%token CHAR INT REAL VOID

%token FUNCTION RETURN
%token IDENTIFIER

%token LPAREN RPAREN
%token LBRACE RBRACE

%token SEMICOLON COMMA
%token ASSIGN

%%
program: function { printf("Parsed function successfully\n");}
        ;

function: FUNCTION IDENTIFIER LPAREN params RPAREN ':' returnType LBRACE block RBRACE 
        ;

returnType: type
        | VOID { flag++; }
        ;

params: params_variables 
        | 
        ;

params_variables: params_variables COMMA variable
        | variable
          ;

variable: type IDENTIFIER
        ;

variable_declaration: type IDENTIFIER value SEMICOLON

value: ASSIGN values  
        | 
        ;

values: literals | IDENTIFIER
        ;

literals: INT_LITERAL
        | REAL_LITERAL
        | CHAR_LITERAL
        ;

type: CHAR
    | INT
    | REAL
    ;

block: variable_declarations_statement assignment_statements return_statement
        | assignment_statements return_statement

assignment_statement: IDENTIFIER ASSIGN values SEMICOLON
        ;

variable_declarations_statement: variable_declarations_statement variable_declaration
        | variable_declaration
        ;

assignment_statements: assignment_statements assignment_statement
        | assignment_statement
        ;

return_statement: RETURN values SEMICOLON { flag++; if(flag >= 2) yyerror("Error: Return statement is illegal for this function"); }
        ;
%%

#include "lex.yy.c"

void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
    fprintf(stderr, "Error at line %d\n", yylineno);
    exit(1);
}

int main() {
    return yyparse();
}