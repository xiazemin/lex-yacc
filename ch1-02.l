%{
/*
* lex verbe
*/
%}
%%

[\t ]+ /*ignore space */

is |
am |
are |
be |
go {printf("%s: is a verb\n",yytext);}
[a-zA-Z]+ {printf("%s: is not a verb \n",yytext);}
.|\n  {ECHO; /*default*/}
%%
int yywrap() 
{ 
   return(1); 
}
int main()
{
yylex();
}
