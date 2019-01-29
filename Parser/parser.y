%{
	void yyerror(char* s);
	#include "stdio.h"
	#include "stdlib.h"
	#include "ctype.h"
	int flag=0;

%}

%token ID NUM_CONST STR_CONST FLT_CONST CHAR_CONST FOR WHILE IF ELSE STRUCT
%token INT CHAR FLOAT DOUBLE LONG SHORT SIGNED UNSIGNED INCLUDE DEFINE VOID
%token MAIN RETURN

%right LEFT_ASSIGN RIGHT_ASSIGN
%right XOR_ASSIGN OR_ASSIGN
%right AND_ASSIGN MOD_ASSIGN
%right MUL_ASSIGN DIV_ASSIGN
%right ADD_ASSIGN SUB_ASSIGN
%right ASSIGN

%left OR_OP
%left AND_OP
%left PIPE
%left CARET
%left AMP 
%left EQ_OP NE_OP
%left LE_OP L_OP GE_OP G_OP
%left LEFT_OP RIGHT_OP 
%left PLUS MINUS
%left MUL DIV MOD

%right SIZEOF
%right TILDE EXL
%left INC_OP DEC_OP 


%start S

%%
S:	INT
	;
%%


int main()
{
	yyparse();
	if(flag == 0)
	{
		printf("Valid\n");
    }
}



void yyerror(char *s)
{
	flag=1;
	printf("Invalid\n");
}