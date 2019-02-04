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

	extern char curid[20];
	extern char curtype[20];
	extern char curval[20];

%}

%token identifier integer_constant string_constant float_constant character_constant FOR WHILE IF ELSE STRUCT DO
%token VOID INT CHAR FLOAT DOUBLE LONG SHORT SIGNED UNSIGNED INCLUDE DEFINE BREAK
%token MAIN RETURN

%right leftshift_assignment_operator rightshift_assignment_operator
%right XOR_assignment_operator OR_assignment_operator
%right AND_assignment_operator modulo_assignment_operator
%right multiplication_assignment_operator division_assignment_operator
%right addition_assignment_operator subtraction_assignment_operator
%right assignment_operator

%left OR_operator
%left AND_operator
%left pipe_operator
%left caret_operator
%left amp_operator
%left equality_operator inequality_operator
%left lessthan_assignment_operator lessthan_operator greaterthan_assignment_operator greaterthan_operator
%left leftshift_operator rightshift_operator 
%left add_operator subtract_operator
%left multiplication_operator division_operator modulo_operator

%right SIZEOF
%right tilde_operator exclamation_operator
%left increment_operator decrement_operator 


%start program

%%
program: declaration_list;

declaration_list
			: declaration D 

D: declaration_list
			| ;

declaration
			: variable_declaration 
			| function_declaration
			| structure_definition;

variable_declaration
			: type_specifier variable_declaration_list ';' | structure_declaration;

variable_declaration_list
			: variable_declaration_identifier V;

V: ',' variable_declaration_list 
			| ;

variable_declaration_identifier 
			: identifier 					{ins();}
			| identifier '[' integer_constant ']'	{ins();}
			| expression					{ins();}
			| identifier '[' integer_constant ']' string_initilization 	{ins();} 
			| identifier '[' ']' string_initilization 				{ins();} 
			| identifier '[' integer_constant ']' array_initialization 	{ins();};


type_specifier
			: INT | CHAR | FLOAT | DOUBLE | LONG | SHORT
			| UNSIGNED INT | UNSIGNED | UNSIGNED LONG
			| LONG INT | UNSIGNED LONG INT | SIGNED SHORT
			| UNSIGNED SHORT |SIGNED SHORT INT | UNSIGNED SHORT INT
			| VOID | STRUCT;


structure_definition
			: STRUCT identifier { ins(); } '{' V '}' ';';

structure_declaration 
			: STRUCT identifier variable_declaration_list;

V : variable_declaration V ;

function_declaration 
			: type_specifier identifier '(' params ')' statement;

params : parameters_list | ;

parameters_list 
			: type_specifier parameters_identifier_list;

parameters_identifier_list 
			: param_identifier ',' parameters_list 
			| param_identifier ;

param_identifier 
			: identifier 		 { ins(); } 
			| identifier '[' ']' { ins(); };

statement 
			: expression_statment | compound_statement 
			| conditional_statements | iterative_statements 
			| return_statement | break_statement 
			| variable_declaration;

compound_statement : '{' statment_list '}' ;

statment_list 
			: statement statment_list 
			| ;

expression_statment 
			: expression ';' 
			| ';' ;

conditional_statements 
			: IF '(' simple_expression ')' statement 
			| IF '(' simple_expression ')' statement ELSE statement ;

iterative_statements 
			: WHILE '(' simple_expression ')' statement 
			| FOR '(' expression ';' simple_expression ';' expression ')' 
			| DO statement WHILE '(' simple_expression ')' ';';

return_statement 
			: RETURN ';' 
			| RETURN expression ';' ;

break_statement 
			: BREAK ';' ;

string_initilization
			: assignment_operator string_constant { insV(); };

array_initialization
			: assignment_operator '{' array_int_declarations '}';

array_int_declarations
			: integer_constant ',' array_int_declarations 
			| integer_constant;

expression 
			: mutable assignment_operator expression 
			| mutable addition_assignment_operator expression 
			| mutable subtraction_assignment_operator expression 
			| mutable multiplication_assignment_operator expression 
			| mutable division_assignment_operator expression 
			| mutable modulo_assignment_operator expression 
			| mutable increment_operator | mutable decrement_operator 
			| simple_expression ;

simple_expression 
			: simple_expression OR_operator and_expression 
			| and_expression ;

and_expression 
			: and_expression AND_operator unary_relation_expression 
			| unary_relation_expression ;

unary_relation_expression 
			: exclamation_operator unary_relation_expression 
			| regular_expression ;

regular_expression 		
			: sum_expression relational_operators sum_expression 
			| sum_expression ;

relational_operators 
			: greaterthan_assignment_operator | lessthan_assignment_operator | greaterthan_operator 
			| lessthan_operator | equality_operator | inequality_operator ;

sum_expression 
			: sum_expression sum_operators term 
			| term ;

sum_operators 
			: add_operator 
			| subtract_operator ;

term
			: term MULOP factor 
			| factor ;

MULOP 
			: multiplication_operator | division_operator | modulo_operator ;

factor 
			: immutable | mutable ;

mutable 
			: identifier 
			| mutable '[' expression ']' 
			| mutable '.' identifier;

immutable 
			: '(' expression ')' 
			| call | constant;

call
			: identifier '(' arguments ')';

arguments 
			: arguments_list | ;

arguments_list 
			: expression A;

A
			: ',' expression A 
			| ;

constant 
			: integer_constant 	{ insV(); } 
			| string_constant	{ insV(); } 
			| float_constant	{ insV(); } 
			| character_constant{ insV(); };

%%

extern FILE *yyin;
extern int yylineno;
extern char *yytext;
void insertSTtype(char *,char *);
void insertSTvalue(char *, char *);
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