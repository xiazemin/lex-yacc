%{
/*
*word table
*/

enum {
LOOKUP=0,//default
VERB,
ADJ,
ADV,
NOUN,
PREP,
PRON,
CONJ
};

int state;

int addWord(int type,char * word);
int lookupWord(char * word);
%}
%%
\n { state= LOOKUP;} /*end of line */
^verb { state=VERB;}
^adj {state=ADJ;}
^adv {state=ADV;}
^noun {state=NOUN;}
^prep {state=PREP;}
^pron {state=PRON;}
^conj {state=CONJ;}
[a-zA-Z]+ {
if (state !=LOOKUP){
addWord(state,yytext);
}else{
switch (lookupWord(yytext)){
 case VERB:printf("%s :verb\n",yytext);break;
 case ADJ:printf("%s :adjctive\n",yytext);break;
 case ADV:printf("%s :adverb\n",yytext);break;
 case NOUN:printf("%s :noun\n",yytext);break;
 case PREP:printf("%s :prepos\n",yytext);break;
 case PRON:printf("%s :pronoun\n",yytext);break;
 case CONJ:printf("%s :adj\n",yytext);break;
 default:printf("%s : don't rec\n",yytext);}
}
}

%%
int yywrap(){
return 1;
}

int main()
{
yylex();
}

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
