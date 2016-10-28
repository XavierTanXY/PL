/*
FILE:		lexer.l
Student ID:	18249833
Name: 		Xhien Yi Tan (Xavier)
Unit:		Programming Languages

*/

%{
	#include <stdio.h>
	#include "y.tab.h"
%}

%%

ARRAY				return TOK_ARRAY;
BEGIN				return TOK_BEGIN;
CALL				return TOK_CALL;
CONST				return TOK_CONST;
DECLARATION			return TOK_DECLARATION;
FUNCTION 			return TOK_FUNCTION;
IMPLEMENTATION		return TOK_IMPLEMENTATION;
OF					return TOK_OF;
PROCEDURE			return TOK_PROCEDURE;
TYPE 				return TOK_TYPE;
VAR					return TOK_VAR;
DO 					return TOK_DO;
EACH				return TOK_EACH;
END 				return TOK_END;
FOR					return TOK_FOR;
IF					return TOK_IF;
IN 					return TOK_IN;
THEN				return TOK_THEN;
WHILE				return TOK_WHILE;
\:=					return TOK_ASSIGNMENT;
\:					return TOK_COLON;
\,					return TOK_COMMA;
\=					return TOK_EQUALS;
\(					return TOK_LEFT_PARENT;
\)					return TOK_RIGHT_PARENT;
\{					return TOK_LEFT_CURLY;
\}					return TOK_RIGHT_CURLY;
\[					return TOK_LEFT_SQUARE;
\]					return TOK_RIGHT_SQUARE;
\;					return TOK_SEMI_COLON;
\.\.				return TOK_TO;
\.					return TOK_PERIOD;
\+					return TOK_ADD;
\-					return TOK_SUBTRACT;
\*					return TOK_MULTIPLY;
\/					return TOK_DIVIDE;
[0-9]+				return TOK_NUMBER;
[a-z]+				return TOK_IDENT;
[ \t\r\n]+			;
.					{
						printf("Unexpected character - %s\n", yytext);
						exit(1);
					}

%%
