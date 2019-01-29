/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    ID = 258,
    NUM_CONST = 259,
    STR_CONST = 260,
    FLT_CONST = 261,
    CHAR_CONST = 262,
    FOR = 263,
    WHILE = 264,
    IF = 265,
    ELSE = 266,
    STRUCT = 267,
    INT = 268,
    CHAR = 269,
    FLOAT = 270,
    DOUBLE = 271,
    LONG = 272,
    SHORT = 273,
    SIGNED = 274,
    UNSIGNED = 275,
    INCLUDE = 276,
    DEFINE = 277,
    VOID = 278,
    MAIN = 279,
    RETURN = 280,
    LEFT_ASSIGN = 281,
    RIGHT_ASSIGN = 282,
    XOR_ASSIGN = 283,
    OR_ASSIGN = 284,
    AND_ASSIGN = 285,
    MOD_ASSIGN = 286,
    MUL_ASSIGN = 287,
    DIV_ASSIGN = 288,
    ADD_ASSIGN = 289,
    SUB_ASSIGN = 290,
    ASSIGN = 291,
    OR_OP = 292,
    AND_OP = 293,
    PIPE = 294,
    CARET = 295,
    AMP = 296,
    EQ_OP = 297,
    NE_OP = 298,
    LE_OP = 299,
    L_OP = 300,
    GE_OP = 301,
    G_OP = 302,
    LEFT_OP = 303,
    RIGHT_OP = 304,
    PLUS = 305,
    MINUS = 306,
    MUL = 307,
    DIV = 308,
    MOD = 309,
    SIZEOF = 310,
    TILDE = 311,
    EXL = 312,
    INC_OP = 313,
    DEC_OP = 314
  };
#endif
/* Tokens.  */
#define ID 258
#define NUM_CONST 259
#define STR_CONST 260
#define FLT_CONST 261
#define CHAR_CONST 262
#define FOR 263
#define WHILE 264
#define IF 265
#define ELSE 266
#define STRUCT 267
#define INT 268
#define CHAR 269
#define FLOAT 270
#define DOUBLE 271
#define LONG 272
#define SHORT 273
#define SIGNED 274
#define UNSIGNED 275
#define INCLUDE 276
#define DEFINE 277
#define VOID 278
#define MAIN 279
#define RETURN 280
#define LEFT_ASSIGN 281
#define RIGHT_ASSIGN 282
#define XOR_ASSIGN 283
#define OR_ASSIGN 284
#define AND_ASSIGN 285
#define MOD_ASSIGN 286
#define MUL_ASSIGN 287
#define DIV_ASSIGN 288
#define ADD_ASSIGN 289
#define SUB_ASSIGN 290
#define ASSIGN 291
#define OR_OP 292
#define AND_OP 293
#define PIPE 294
#define CARET 295
#define AMP 296
#define EQ_OP 297
#define NE_OP 298
#define LE_OP 299
#define L_OP 300
#define GE_OP 301
#define G_OP 302
#define LEFT_OP 303
#define RIGHT_OP 304
#define PLUS 305
#define MINUS 306
#define MUL 307
#define DIV 308
#define MOD 309
#define SIZEOF 310
#define TILDE 311
#define EXL 312
#define INC_OP 313
#define DEC_OP 314

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
