%{
/*
* lex
*/
#include "y.tab.h"
#define LOOKUP 0
int state;
int addWord(int type,char * word);
int lookupWord(char * word);
%}

%%
\n {state =LOOKUP;}
\.\n {state=LOOKUP;
    return 0;
}

^verb {state=VERB;}
^adj {state=ADJECTIVE;}
^adv {state=ADVERB;}
^noun {state=NOUN;}
^prep {state=PREPOSITION;}
^pron {state=PRNOUN;}
^conj {state=CONJUNCTION;}

[a-zA-Z]+ {  
  if(state!=LOOKUP){
addWord(state,yytext);
}else{
switch(lookupWord(yytext)){
case VERB:
 return (VERB);
case ADJECTIVE:
 return(ADJECTIVE);
case ADVERB:
 return (ADVERB);
case NOUN:
  return (NOUN);
case PREPOSITION:
 return (PREPOSITION);
case PRNOUN:
  return (PRNOUN);
case CONJUNCTION:
   return (CONJUNCTION);
default :
printf("%s: don't recoginise\n",yytext);
}
}
}
;

%%

int yywrap(){
return 1;
}
/*
int main()
{
yylex();
}
*/

struct word{
  char *wordName;
  int wordType;
  struct word* next;
};

struct word *wordList;
extern void * malloc();
int addWord(int type,char* word){
struct word* wp;
if(lookupWord(word)!=LOOKUP){
printf(" !! word %s is already defined \n",word);
return 0;
}

wp=(struct word * ) malloc(sizeof(struct word));
wp->next=wordList;

wp->wordName=(char* ) malloc(strlen(word)+1);
strcpy(wp->wordName,word);
wp->wordType=type;

wordList=wp;
return 1;
}

int lookupWord(char*word){
struct word *wp=wordList;
for(;wp;wp=wp->next){
if(strcmp(wp->wordName,word)==0)
return wp->wordType;
}
return LOOKUP;}
