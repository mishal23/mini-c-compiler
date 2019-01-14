#!/bin/bash
function run() {
	lex scanner1.l && gcc lex.yy.c
	local total_testcases="$1"
	echo "Running: $total_testcases"
	local start=1
	while [ $start -le $total_testcases ]
	do
		echo `\n\n`
		echo Running TestCase $start
		local filename="tests/test"$start".c"
		./a.out $filename
		((start++))
	done
}

number_of_files=`ls -l ./tests/ | egrep -c '^-'`
run $number_of_files