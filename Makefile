pl: lex.yy.c y.tab.c
	cc lex.yy.c y.tab.c -o PL2016_check

lex.yy.c: y.tab.c lexer.l
	lex lexer.l

y.tab.c: parser.y
	yacc -d parser.y

clean: 
	rm -f lex.yy.c y.tab.c y.tab.h PL2016_check