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
LE <=
GE >=
EQ ==
NE \!=
G >
L <
OR \|\|
AND &&
NOT \!
ASS =
ADDASS \+=
SUBASS \-=
MULASS \*=
DIVASS \/=
MODASS \%=
PLUS \+
SUB \-
MULT \*
DIV \/
MOD \%
PP \+\+
MM \-\-
BA &
BO \|
OC ~
LS <<
RS >>

operator [[<][=]|[>][=]|[=][=]|[!][=]|[>]|[<]|[\|][\|]|[&][&]|[\!]|[=]|[\+][=]|[\-][=]|[\*][=]|[\/][=]|[\%][=]|[\+][\+]|[\-][\-]|[\+]|[\-]|[\*]|[\/]|[\%]|[&]|[\|]|[~]|[<][<]|[>][>]]
letter [A-Z|a-z]
digit [0-9]

%%
\n   {yylineno++;}
([#!](" ")*({DE}|{IN})(" ")*([<]?)([A-Za-z]+)[.]?([A-Za-z]*)([>]?)(" ")*([A-Za-z0-9]*))/["\n"] {printf("%s \t-Pre Processor directive\n",yytext);}
\/\/(.*) {printf("%s \t- SINGLE LINE COMMENT\n", yytext);}				
\/\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+\/  {printf("%s \t- MULTI LINE COMMENT\n", yytext);}
[ \n\t] ;
; {printf("%s \t- SEMICOLON DELIMITER\n", yytext);}
, {printf("%s \t- COMMA DELIMITER\n", yytext);}
\{ {printf("%s \t- OPENING BRACES\n", yytext);}
\} {printf("%s \t- CLOSING BRACES\n", yytext);}
\( {printf("%s \t- OPENING BRACKETS\n", yytext);}
\) {printf("%s \t- CLOSING BRACKETS\n", yytext);}
\\ {printf("%s \t- FSLASH\n", yytext);}
\. {printf("%s \t- DOT DELIMITER\n", yytext);}
auto|break|case|char|const|continue|default|do|double|else|enum|extern|float|for|goto|if|int|long|register|return|short|signed|sizeof|static|struct|switch|typedef|union|unsigned|void|volatile|while|main/[\(|" "|\{|;] {printf("%s \t- KEYWORD\n", yytext); insertST(yytext, "KEYWORD");}
\"[^\n]*\"/[;|,|)] {printf("%s \t- STRING CONSTANT\n", yytext); insertCT(yytext,"STRING CONSTANT");}
\'[A-Z|a-z]\'/[;|,|)] {printf("%s \t- Character CONSTANT\n", yytext); insertCT(yytext,"Character CONSTANT");}
[a-z|A-Z]([a-z|A-Z]|[0-9])*\[[0-9]*\]/[{operator}|,|;|\)|" "] {printf("%s \t- ARRAY IDENTIFIER\n", yytext); insertST(yytext, "IDENTIFIER");}

{operator}/[a-z]|{digit}|;|" "|[A-Z] {printf("%s \t- OPERATOR\n", yytext);} 

[1-9][0-9]*|0/[;|,|" "|\)] {printf("%s \t- NUMBER CONSTANT\n", yytext); insertCT(yytext, "NUMBER CONSTANT");}
([0-9]*)\.([0-9]+)/[;|,|" "|\)] {printf("%s \t- Floating CONSTANT\n", yytext); insertCT(yytext, "Floating CONSTANT");}
{letter}({letter}|{digit})*/[" "|;|,|\(|\)|<|>|=|\!|\||&|\+|\-|\*|\/|\%|~] {printf("%s \t- IDENTIFIER\n", yytext); insertST(yytext, "IDENTIFIER");}



(.?) {printf("Error at line no. %d\n", yylineno); return 0;}

%%







int main(){

    int i;
    for (i=0;i<1001;i++){
        ST[i].length=0;
        CT[i].length=0;
    }
    yyin=fopen("tests/test2.c","r");
    yylex();
   
    printf("\n\nSYMBOL TABLE\n\n");
    
    printST();

    printf("\n\nCONSTANT TABLE\n\n");
    printCT();
}

int yywrap(){
    return 1;
}