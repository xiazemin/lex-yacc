%{
/*
*english gramer
*/
#include <stdio.h>
void yyerror(char *);
%}

%token NOUN PRNOUN VERB ADVERB ADJECTIVE PREPOSITION CONJUNCTION

%%

sentence: subject VERB object { printf ("sentense \n");}
;
subject: NOUN
| PRNOUN
;

object: NOUN
;
%%
extern FILE *yyin;
int main(){

do {
yyparse();
}
while(!feof(yyin));
}
void yyerror(s)
char*s;
{
fprintf(stderr,"%s\n",s);
}


