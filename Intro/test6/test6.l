%%
[0-9]+	{ yylval = atoi(yytext); return NUM; }
[ \s]+ ;
. 	return yytext[0];
%%
