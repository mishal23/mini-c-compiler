%{
	void yyerror(char* s);
	#include "stdio.h"
	#include "stdlib.h"
	#include "ctype.h"
	#include "string.h"
	int flag=0;

%}

%token ID NUM_CONST STR_CONST FLT_CONST CHAR_CONST FOR WHILE IF ELSE STRUCT
%token INT CHAR FLOAT DOUBLE LONG SHORT SIGNED UNSIGNED INCLUDE DEFINE VOID BREAK
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


%start PRG

%%
PRG: DECL;
DECL: DECL DEC | DEC;
DEC: VDEC | FDEC;
VDEC: TSPEC VDECL ';';
VDECL: VDECL','VDECI | VDECI ;
VDECI: VDECID | ;
VDECID : ID | ID '[' NUM_CONST ']';
TSPEC : RTSPEC | ;
RTSPEC : INT|CHAR|FLOAT|DOUBLE|LONG|SHORT;
FDEC : TSPEC ID '(' PARAMS ')' STMT ;
PARAMS : PARAMTL | ;
PARAMTL : TSPEC PARAMIDL;
PARAMIDL : PARAMIDL','PARAMTL | PARAMID ;
PARAMID : ID | ID '[' ']';
STMT : EXSTMT | CSTMT | SSTMT | ISTMT | RSTMT | BSTMT;
CSTMT : '{' LDEC STMTL '}' ;
LDEC : LDEC VDEC | ;
STMTL : STMT STMTL | ;
EXSTMT : EX ';'| ';';
SSTMT : IF '(' SEXP ')' STMT | IF '(' SEXP ')' STMT ELSE STMT ;
ISTMT : WHILE'('SEXP ')'STMT | FOR '(' EX ';' SEXP ';' EX ')';
RSTMT : RETURN ';' | RETURN EX ';' ;
BSTMT : BREAK ';' ;
EX : MUT ASSIGN EX | MUT ADD_ASSIGN EX |  MUT SUB_ASSIGN EX | MUT MUL_ASSIGN EX | MUT DIV_ASSIGN EX | MUT MOD_ASSIGN EX | MUT INC_OP | MUT DEC_OP | SEXP ;
SEXP : SEXP OR_OP ANDEXP | ANDEXP ;
ANDEXP : ANDEXP AND_OP UREXP | UREXP ;
UREXP : EXL UREXP | REXP ;
REXP : SUMEXP RELOP SUMEXP | SUMEXP ;
RELOP : GE_OP | LE_OP | G_OP | L_OP | EQ_OP | NE_OP ;
SUMEXP : SUMEXP SUMOP TERM | TERM ;
SUMOP : PLUS | MINUS ;
TERM : TERM MULOP FACTOR | FACTOR ;
MULOP : MUL | DIV | MOD ;
FACTOR : IMUT | MUT ;
MUT : ID | MUT '[' EX ']' | MUT '.' ID;
IMUT : '(' EX ')' | CALL | CONST;
CALL : ID '(' ARGS ')';
ARGS : ARGSLIST | ;
ARGSLIST : ARGSLIST ',' EX | EX ;
CONST : NUM_CONST | STR_CONST | FLT_CONST | CHAR_CONST;

%%

extern FILE *yyin;
extern char *yytext;
extern int yylineno;
int main()
{
	yyin = fopen("../Lexical-Analyzer/tests/test7.c", "r");
	yyparse();

	if(flag == 0)
	{
		printf("Valid\n");
    }
}



void yyerror(char *s)
{
	printf("%d %s %s\n", yylineno, s, yytext);
	flag=1;
	printf("Invalid\n");
}