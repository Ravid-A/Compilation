%%
August		{ yylval = 8; return AUGUST; }
September	{ yylval = 9; return SEPTEMBER; }
October		{ yylval = 10; return OCTOBER; }
November	{ yylval = 11; return NOVEMBER; }
December	{ yylval = 12; return DECEMBER; }
20[0-9][0-9]	{ yylval = atoi(yytext); return YEAR; }
.		return yytext[0];
%%
