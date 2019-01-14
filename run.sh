#!/bin/bash

lex scanner1.l && gcc lex.yy.c && ./a.out