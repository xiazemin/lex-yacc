%{
#include <stdio.h>
%}
%token NOUN PRNOUN VERB ADVERB ADJECTIVE PREPOSITION CONJUNCTION
%%

sentense :simple_sentense {printf ("simple sentense\n");}
 | compound_sentense {printf ("compound sentense \n");}
;

simple_sentense:subject verb object
| subject verb object prep_phase
;

compound_sentense : simple_sentense CONJUNCTION simple_sentense
  | compound_sentense CONJUNCTION simple_sentense
;

subject: NOUN
  | PRNOUN 
  | ADJECTIVE subject
;

verb: VERB
|ADVERB VERB
|verb VERB
;

object: NOUN
| ADJECTIVE object
;

prep_phase: PREPOSITION NOUN
;

%%

extern FILE* yyin;
int main()
{
do {
yyparse();
}
while(!feof(yyin));
}

yyeror(s)
char* s;
{
fprintf(stderr, "%s\n",s);
}

