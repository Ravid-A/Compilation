%%
[ \s]+	;
[0-9]+	{ return NUM; }
\+	{ return PLUS; }
\-	{ return MINUS; }
%%
