%{
	void yyerror(char* s);
	int yylex();
	#include "stdio.h"
	#include "stdlib.h"
	#include "ctype.h"
	#include "string.h"
	void ins();
	void insV();
	int flag=0;

%}

%token ID NUM_CONST STR_CONST FLT_CONST CHAR_CONST FOR WHILE IF ELSE STRUCT DO
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
DECL:DEC DECL | DEC;
DEC: VDEC | FDEC;
VDEC: TSPEC VDECL ';';
VDECL: VDECID','VDECL | VDECID ;
VDECID : ID {ins();}| ID '[' NUM_CONST ']'{ins();} | EX{ins();} | ID '[' NUM_CONST ']' STR_INIT{ins();} | ID '[' ']' STR_INIT{ins();} | ID '[' NUM_CONST ']' ARR_INIT{ins();};
TSPEC : INT|CHAR|FLOAT|DOUBLE|LONG|SHORT|UNSIGNED INT|UNSIGNED|UNSIGNED LONG|LONG INT|UNSIGNED LONG INT|SIGNED SHORT| UNSIGNED SHORT|SIGNED SHORT INT|UNSIGNED SHORT INT;
FDEC : TSPEC ID '(' PARAMS ')' STMT {ins();};
PARAMS : PARAMTL | ;
PARAMTL : TSPEC PARAMIDL;
PARAMIDL : PARAMID ',' PARAMTL | PARAMID ;
PARAMID : ID {ins();} | ID '[' ']'{ins();};
STMT : EXSTMT | CSTMT | SSTMT | ISTMT | RSTMT | BSTMT | VDEC;
CSTMT : '{' STMTL '}' ;
STMTL : STMT STMTL | ;
EXSTMT : EX ';'| ';';
SSTMT : IF '(' SEXP ')' STMT | IF '(' SEXP ')' STMT ELSE STMT ;
ISTMT : WHILE'('SEXP ')'STMT | FOR '(' EX ';' SEXP ';' EX ')' | DO STMT WHILE '(' SEXP ')' ';';
RSTMT : RETURN ';' | RETURN EX ';' ;
BSTMT : BREAK ';' ;
STR_INIT: ASSIGN STR_CONST {insV();};
ARR_INIT: ASSIGN '{' NUM_DELI '}';
NUM_DELI: NUM_CONST ',' NUM_DELI | NUM_CONST; 
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
ARGSLIST : EX A;
A : ',' EX A | ;
CONST : NUM_CONST {insV();} | STR_CONST{insV();} | FLT_CONST{insV();} | CHAR_CONST{insV();};
%%

extern FILE *yyin;
extern int yylineno;
extern char *yytext;
void insertSTtype(char *,char *);
extern char curid[20];
extern char curtype[20];
extern char curval[20];
void incertCT(char *, char *);
void printST();
void printCT();


int main(int argc , char **argv)
{
	yyin = fopen(argv[1], "r");
	yyparse();

	if(flag == 0)
	{
		printf("Valid\n");
    }
    printf("----------Symbol Table-----------------\n");
    printST();
    printf("----------Constant Table----------------\n");
    printCT();

}



void yyerror(char *s)
{
	printf("%d %s %s\n", yylineno, s, yytext);
	flag=1;
	printf("Invalid\n");
}

void ins()
{
	insertSTtype(curid,curtype);
}

void insV()
{
	insertSTvalue(curid,curval);
}


int yywrap()
{
	return 1;
}