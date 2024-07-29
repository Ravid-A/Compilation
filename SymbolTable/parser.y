%union {
	char *s;
};

%{
#include<stdio.h>
#include <string.h>

int yylex();
void print();
void test();
int yyerror(char* err);
char id_arr[10][10],id[10];
int type_arr[10],i = 0, j = 0, k = 0;
int flag = 0, first_type = 0;

int yycolumn = 0;
%}

%token INT DOUBLE CHAR
%token<s> ID

%%

S: EXP { printf("OK\n"); print(); test(); }
EXP: EXP DEF | DEF;
DEF: INT ID ';' { strcpy(id_arr[i],$2); i++; type_arr[j]=0; j++; };
	| DOUBLE ID ';' { strcpy(id_arr[i],$2); i++; type_arr[j]=1; j++; };
	| CHAR ID ';' { strcpy(id_arr[i],$2); i++; type_arr[j]=2; j++; };

%%

#include "lex.yy.c"

int main()
{
	printf("ENTER ID NAME : ");
	scanf("%s\n ",id);
	return yyparse();
}

int yyerror(char* err)
{
	printf("Error: %s\n",err);
    printf("Errorat [%d,%d]\n",yylineno,yycolumn);
	exit(1);
}

void print()
{
	for(k=0;k<i;k++)
	{
		printf("%d ",type_arr[k]);
		printf("%s\n",id_arr[k]);
	}
}

void test()
{
	for(k=0;k<i;k++)
	{
		if(strcmp(id_arr[k],id)==0)
		{
			if(flag==0)
			{
				flag=1;
				first_type=type_arr[k];
			}
			else
			{
				if(first_type==type_arr[k])
					printf("DECLARATION ERROR %s\n",id);
				else
					printf("REDECLARATION %s\n",id);
			}
		}
	}
}