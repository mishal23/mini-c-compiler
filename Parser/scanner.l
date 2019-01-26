%{
	#include <stdio.h>
	#include <string.h>
	

	struct symboltable
	{
		char name[100];
		char type[100];
		int length;
	}ST[1001];

	struct constanttable
	{
		char name[100];
		char type[100];
		int length;
	}CT[1001];

	int hash(char *str)
	{
		int value = 0;
		for(int i = 0 ; i < strlen(str) ; i++)
		{
			value = 10*value + (str[i] - 'A');
			value = value % 1001;
			while(value < 0)
			value = value + 1001;

		}
		return value;
	}

	int lookupST(char *str)
	{
		int value = hash(str);
		if(ST[value].length == 0)
		{
			return 0;
		}
		else if(strcmp(ST[value].name,str)==0)
		{	
		    return 1;
		}
		else
		{
			for(int i = value + 1 ; i!=value ; i = (i+1)%1001)
	    	{
	    		if(strcmp(ST[i].name,str)==0)
	    		{
	    			return 1;
	    		}
	    	}
	    	return 0;
	    }
	}

	int lookupCT(char *str)
	{
		int value = hash(str);
		if(CT[value].length == 0)
		    return 0;
		else if(strcmp(CT[value].name,str)==0)
		    return 1;
		else
	    {
	    	for(int i = value + 1 ; i!=value ; i = (i+1)%1001)
	    	{
	    		if(strcmp(CT[i].name,str)==0)
	    		{
	    			return 1;
	    		}
	    	}
	    	return 0;
	    }
	}

	void insertST(char *str1, char *str2)
	{
		if(lookupST(str1))
		{
		    return;
	    }
		else
		{
			int value = hash(str1);
			if(ST[value].length == 0)
			{
				strcpy(ST[value].name,str1);
				strcpy(ST[value].type,str2);
				ST[value].length = strlen(str1);
				return;
			}

            int pos = 0;

            for (int i = value + 1 ; i!=value ; i = (i+1)%1001)
            {
            	if(ST[i].length == 0)
            	{
            		pos = i;
            		break;
            	}
            }

            strcpy(ST[pos].name,str1);
            strcpy(ST[pos].type,str2);
            ST[pos].length = strlen(str1);
		}
    }

    void insertCT(char *str1, char *str2)
	{
		if(lookupCT(str1))
			return;
		else
		{
			int value = hash(str1);
			if(CT[value].length == 0)
			{
				strcpy(CT[value].name,str1);
				strcpy(CT[value].type,str2);
				CT[value].length = strlen(str1);
				return;
			}

            int pos = 0;

            for (int i = value + 1 ; i!=value ; i = (i+1)%1001)
            {
            	if(CT[i].length == 0)
            	{
            		pos = i;
            		break;
            	}
            }

            strcpy(CT[pos].name,str1);
            strcpy(CT[pos].type,str2);
            CT[pos].length = strlen(str1);
		}
    }

    void printST()
    {
    	for(int i = 0 ; i < 1001 ; i++)
    	{
    		if(ST[i].length == 0)
    		{
    			continue;
    	    }

    		printf("%s\t%s\n",ST[i].name, ST[i].type);
    	}

    }


    void printCT()
    {
    	for(int i = 0 ; i < 1001 ; i++)
    	{
    		if(CT[i].length == 0)
    			continue;

    		printf("%s\t%s\n",CT[i].name, CT[i].type);
    	}
    }


%}

DE "define"
IN "include"

operator [[<][=]|[>][=]|[=][=]|[!][=]|[>]|[<]|[\|][\|]|[&][&]|[\!]|[=]|[\^]|[\+][=]|[\-][=]|[\*][=]|[\/][=]|[\%][=]|[\+][\+]|[\-][\-]|[\+]|[\-]|[\*]|[\/]|[\%]|[&]|[\|]|[~]|[<][<]|[>][>]]


%%
\n   {yylineno++;}
([#][" "]*({IN})[ ]*([<]?)([A-Za-z]+)[.]?([A-Za-z]*)([>]?))/["\n"|\/|" "|"\t"] { }
([#][" "]*({DE})[" "]*([A-Za-z]+)(" ")*[0-9]+)/["\n"|\/|" "|"\t"] {  } 
\/\/(.*) { }				
\/\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+\/  {  }
[ \n\t] ;
; {return(';');}
, { return(','); }
("{") {return('{');}
("}") {return('}');}
"("	  {  return('('); }
")"	  {  return(')'); }
\[ {return('[');}
\] {return(']');}
\: {return(':');}
\\ {return('\');}
\. {return('.');}

auto 	{return AUTO;}
break 	{return BREAK;}
case 	{return CASE;}
char 	{return CHAR;}
const 	{return CONST;}
continue{return CONT;}
default {return DEF;}
do 		{return DO;}
double	{return DOUBLE;}
else 	{return ELSE;}
enum 	{return ENUM;}
extern	{return EXTERN;}
float 	{return FLOAT;}
for		{return FOR;}
goto	{return GOTO;}
if 		{return IF;}
int 	{return INT;}
long	{return LONG;}
register{return REGISTER;}
return	{return RETURN;}
short	{return SHORT;}
signed	{return SIGNED;}
sizeof 	{return SIZEOF;}
static	{return STATIC;}
struct	{return STRCUT;}
switch	{return SWITCH;}
typedef	{return TYPEDEF;}
union	{return UNION;}
unsigned{return UNSIGNED;}
void	{return VOID;}
volatile{return VOLAT;}
while	{return WHILE;}
main	{return MAIN;}
\"[^\n]*\"/[;|,|\)] {printf("%s \t- STRING CONSTANT\n", yytext); insertCT(yytext,"STRING CONSTANT");}
\'[A-Z|a-z]\'/[;|,|\)|:] {printf("%s \t- Character CONSTANT\n", yytext); insertCT(yytext,"Character CONSTANT");}
[a-z|A-Z]([a-z|A-Z]|[0-9])*/\[ {printf("%s \t- ARRAY IDENTIFIER\n", yytext); insertST(yytext, "IDENTIFIER");}


\"[^\n]*\"/[;|,|\)] {yylval = yytext; return STRING; insertCT(yytext,"STRING CONSTANT");}
\'[A-Z|a-z]\'/[;|,|\)|:] {yylval = yytext; return CHAR_CONST; insertCT(yytext,"Character CONSTANT");}
[a-z|A-Z]([a-z|A-Z]|[0-9])*/\[ {yylval = yytext; return ARRAY_IDENTIFIER; insertST(yytext, "IDENTIFIER");}


"++"			{  return INC_OP; }
"--"			{  return DEC_OP; }
"<<"			{  return LEFT_OP; }
">>"			{  return RIGHT_OP; }
"<="			{  return LE_OP; }
"<"				{  return L_OP; }
">="			{  return GE_OP; }
">"				{  return G_OP; }
"=="			{  return EQ_OP; }
"!="			{  return NE_OP; }
"&&"			{  return AND_OP; }
"||"			{  return OR_OP; }
"^"				{  return CARET; }
"*="			{  return MUL_ASSIGN; }
"/="			{  return DIV_ASSIGN; }
"%="			{  return MOD_ASSIGN; }
"+="			{  return ADD_ASSIGN; }
"-="			{  return SUB_ASSIGN; }
"<<="			{  return LEFT_ASSIGN; }
">>="			{  return RIGHT_ASSIGN; }
"&="			{  return AND_ASSIGN; }
"^="			{  return XOR_ASSIGN; }
"|="			{  return OR_ASSIGN; }
"&"				{  return AMP; }
"!"				{  return EXL; }
"~"				{  return TILDE; }
"-"				{  return MINUS; }
"+"				{  return PLUS; }
"*"				{  return MUL; }
"/"				{  return DIV; }
"%"				{  return MOD; }
"|"				{  return PIPE; }
"?"				{  return QUES; }
{operator}/[a-z]|[0-9]|;|" "|[A-Z]|\(|\"|\'|\)|\n|\t {printf("%s \t- OPERATOR\n", yytext);} 

[1-9][0-9]*|0/[;|,|" "|\)|<|>|=|\!|\||&|\+|\-|\*|\/|\%|~|\]|\}|:|\n|\t|\^] {yylval = yytext; return INT_CONSTANT; insertCT(yytext, "NUMBER CONSTANT");}
([0-9]*)\.([0-9]+)/[;|,|" "|\)|<|>|=|\!|\||&|\+|\-|\*|\/|\%|~|\n|\t|\^] {yylval = yytext; return FLOAT_CONSTANT; insertCT(yytext, "Floating CONSTANT");}
[A-Za-z_][A-Za-z_0-9]*/[" "|;|,|\(|\)|<|>|=|\!|\||&|\+|\-|\*|\/|\%|~|\n|\.|\{|\^|\t] {yylval = yytext; return IDENTIFIER; insertST(yytext, "IDENTIFIER");}



(.?) {
		if(yytext[0]=='#')
		{
       		printf("Error in Pre-Processor directive at line no. %d\n",yylineno);
       	}
	    else if(yytext[0]=='/')
	    {
       		printf("ERR_UNMATCHED_COMMENT at line no. %d\n",yylineno);
       	}
       	else if(yytext[0]=='"')
       	{
       		printf("ERR_INCOMPLETE_STRING at line no. %d\n",yylineno);
       	}
       	else
       	{
       		printf("ERROR at line no. %d\n",yylineno);
       	}
       	printf("%s\n", yytext);
       	return 0;
}

%%

int main(int argc , char **argv)
{

    printf("====================================================================\n");

	int i;
	for (i=0;i<1001;i++){
		ST[i].length=0;
		CT[i].length=0;
	}

	yyin = fopen(argv[1],"r");
	yylex();
	
	printf("\n\nSYMBOL TABLE\n\n");
	printST();
	printf("\n\nCONSTANT TABLE\n\n");
	printCT();
}

int yywrap()
{
    return 1;
}