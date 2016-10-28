/*
FILE:		parser.y
Student ID:	18249833
Name: 		Xhien Yi Tan (Xavier)
Unit:		Programming Languages

*/

%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	
	int yylex();
	void yyerror(char *s);

	void found(char* string)
	{
		printf("Found %s\n", string);
	}

%}

%token			TOK_ARRAY
%token			TOK_BEGIN
%token			TOK_CALL
%token			TOK_CONST		
%token			TOK_DECLARATION	
%token			TOK_FUNCTION 
%token			TOK_IMPLEMENTATION	
%token			TOK_OF	
%token			TOK_PROCEDURE
%token			TOK_TYPE 				
%token			TOK_VAR	
%token			TOK_DO	
%token			TOK_EACH	
%token			TOK_END 
%token			TOK_FOR				
%token			TOK_IF	
%token			TOK_IN
%token			TOK_THEN
%token 			TOK_WHILE	
%token 			TOK_ASSIGNMENT
%token			TOK_COLON
%token 			TOK_COMMA
%token 			TOK_EQUALS
%token 			TOK_LEFT_PARENT
%token			TOK_RIGHT_PARENT
%token 			TOK_LEFT_CURLY
%token			TOK_RIGHT_CURLY
%token 			TOK_LEFT_SQUARE
%token			TOK_RIGHT_SQUARE
%token			TOK_SEMI_COLON	
%token 			TOK_TO
%token			TOK_PERIOD
%token 			TOK_ADD
%token			TOK_SUBTRACT
%token			TOK_MULTIPLY
%token			TOK_DIVIDE
%token			TOK_NUMBER	
%token			TOK_IDENT

%%

basic_program : 

	declaration_unit
	{ found("basic_program"); }
	| 
	implementation_unit
	{ found("basic_program"); }
	;

declaration_unit : 

	TOK_DECLARATION 	
	TOK_OF
	TOK_IDENT
	optional_const_and_constant_declaration
	optional_var_and_var_declaration	
	optional_type_declaration
	optional_procedure_interface
	optional_function_interface
	TOK_DECLARATION
	TOK_END
	{ found("declaration_unit"); }
	;

optional_const_and_constant_declaration :

	{ } 
	|
	TOK_CONST
	constant_declaration
	{ } 
	;

optional_var_and_var_declaration : 

	{ } 
	|
	TOK_VAR
	variable_declaration
	{ } 
	;

optional_type_declaration :

	{ } 
	|
	type_declaration
	{ } 
	;

optional_procedure_interface :

	{ } 
	|
	procedure_interface
	{ } 
	;

optional_function_interface :

	{ } 
	|
	function_interface
	{ }
	;

procedure_interface :
	
	TOK_PROCEDURE
	TOK_IDENT
	optional_formal_parameters
	{ found("procedure_interface"); }
	;

function_interface :

	TOK_FUNCTION
	TOK_IDENT
	optional_formal_parameters
	{ found("function_interface"); }
	;

optional_formal_parameters :

	{ } 
	|
	formal_parameters 
	{ } 
	;

type_declaration :
	
	TOK_TYPE
	TOK_IDENT
	TOK_COLON
	type
	TOK_SEMI_COLON
	{ found("type_declaration"); } 
	;

formal_parameters :

	TOK_LEFT_PARENT
	semi_colon_and_ident
	TOK_RIGHT_PARENT
	{ found("formal_parameters"); } 
	;

semi_colon_and_ident :

	TOK_IDENT
	{ found("semi_colon_and_ident"); } 
	|
	semi_colon_and_ident
	TOK_SEMI_COLON 
	TOK_IDENT
	{ found("semi_colon_and_ident"); } 
	;

constant_declaration :

	constant_declaration_part2
	TOK_SEMI_COLON
	{ found("constant_declaration"); } 
	;

constant_declaration_part2 :

	constant_declaration_part1 
	{ found("constant_part2"); } 
	|
	constant_declaration_part2
	TOK_COMMA
	constant_declaration_part1
	{ found("constant_part2"); }
	;

constant_declaration_part1 :

	TOK_IDENT
	TOK_EQUALS
	TOK_NUMBER
	{ found("constant_part1"); } 
	;

variable_declaration :

	variable_declaration_part2
	TOK_SEMI_COLON
	{ found("variable_declaration"); } 
	;

variable_declaration_part2 :

	variable_declaration_part1
	{ found("variable_declaration_part2"); } 
	|
	variable_declaration_part2
	TOK_COMMA
	variable_declaration_part1
	{ found("variable_declaration_part2"); } 
	;


variable_declaration_part1 :

	TOK_IDENT
	TOK_COLON
	TOK_IDENT
	{ found("variable_declaration_part1"); } 
	;

type :

	basic_type
	{ found("type"); } 
	|
	array_type
	{ found("type"); } 
	;

basic_type :

	TOK_IDENT
	{ found("basic_type"); } 
	|
	enumerated_type
	{ found("basic_type"); } 
	|
	range_type
	{ found("basic_type"); } 
	;

enumerated_type :
	
	TOK_LEFT_CURLY
	comma_and_ident
	TOK_RIGHT_CURLY
	{ found("enumerated_type"); }
	;

comma_and_ident :

	TOK_IDENT
	{ found("comma_and_ident"); }
	|
	comma_and_ident
	TOK_COMMA
	TOK_IDENT
	{ found("comma_and_ident"); }
	;

range_type :

	TOK_LEFT_SQUARE
	range
	TOK_RIGHT_SQUARE
	{ found("range_type"); }
	;

array_type :

	TOK_ARRAY
	TOK_IDENT
	TOK_LEFT_SQUARE
	range
	TOK_RIGHT_SQUARE
	TOK_OF
	type
	{ found("array_type"); }
	;

range :

	TOK_NUMBER
	TOK_TO
	TOK_NUMBER
	{ found("range"); }
	;

implementation_unit : 

	TOK_IMPLEMENTATION
	TOK_OF
	TOK_IDENT
	block
	TOK_PERIOD
	{ found("implementation_unit"); }
    ;

block :

	specification_part
	implementation_part
	{ found("block"); }
	;

specification_part :

	{ found("specification_part"); }
	|
	TOK_CONST
	constant_declaration
	{ found("specification_part"); }
	|
	TOK_VAR
	variable_declaration
	{ found("specification_part"); }
	|
	procedure_declaration
	{ found("specification_part"); }
	|
	function_declaration
	{ found("specification_part"); }
	;

procedure_declaration :

	TOK_PROCEDURE
	ident_and_semi_colon_and_block
	{ found("procedure_declaration"); }
	;

function_declaration :

	TOK_FUNCTION
	ident_and_semi_colon_and_block
	{ found("function_declaration"); }
	;

ident_and_semi_colon_and_block :
	
	TOK_IDENT
	TOK_SEMI_COLON
	block
	TOK_SEMI_COLON
	{ found("ident_and_semi_colon_and_block"); }
	;

implementation_part :

	compound_statement
	{ found("implementation_part"); }
	;

statement :

	assignment
	{ found("assignment statement"); }
	|
	procedure_call
	{ found("procedure_call statement"); }
	|
	if_statement
	{ found("if_statement"); }
	|
	while_statement
	{ found("while_statement"); }
	|
	do_statement
	{ found("do_statement"); }
	|
	for_statement
	{ found("for_statement"); }
	|
	compound_statement
	{ found("compound_statement"); }
	;

assignment :

	TOK_IDENT
	TOK_ASSIGNMENT
	expression
	{ found("assignment"); }
	;

procedure_call :

	TOK_CALL
	TOK_IDENT
	{ found("procedure_call"); }
	;

if_statement :
	
	TOK_IF
	expression
	TOK_THEN
	compound_statement
	TOK_END
	TOK_IF
	{ found("if_statement"); }
	;

while_statement :

	TOK_WHILE
	expression
	TOK_DO
	compound_statement
	TOK_END
	TOK_WHILE
	{ found("while_statement"); }
	;

do_statement :

	TOK_DO
	compound_statement
	TOK_WHILE
	expression
	TOK_END
	TOK_DO
	{ found("do_statement"); }
	;

for_statement :

	TOK_FOR
	TOK_EACH
	TOK_IDENT
	TOK_IN
	TOK_IDENT
	TOK_DO
	compound_statement
	TOK_END
	TOK_FOR
	{ found("for_statement"); }
	;

compound_statement :

	TOK_BEGIN
	semi_colon_and_statement
	TOK_END
	{ found("compound_statement"); }
	;

semi_colon_and_statement :

	statement
	{ found("semi_colon_and_statement"); }
	|
	semi_colon_and_statement
	TOK_SEMI_COLON
	statement
	{ found("semi_colon_and_statement"); }
	;

expression :

	add_substract_term
	{ found("expression"); }
	;

add_substract_term :

	term
	{ found("add_substract_term"); }
	|
	add_substract_term
	TOK_ADD
	term
	{ found("add_substract_term"); }
	|
	add_substract_term
	TOK_SUBTRACT
	term
	{ found("add_substract_term"); }
	;

term :

	multiply_divide_id_num
	{ found("term"); }
	;

multiply_divide_id_num :

	id_num
	{ found("multiply_divide_id_num"); }
	|
	multiply_divide_id_num
	TOK_MULTIPLY
	id_num
	{ found("multiply_divide_id_num"); }
	|
	multiply_divide_id_num
	TOK_DIVIDE
	id_num
	{ found("multiply_divide_id_num"); }
	;

id_num :

	TOK_IDENT
	{ found("id_num"); }
	|
	TOK_NUMBER
	{ found("id_num"); }
	;

%%

int yydebug = 1;

int main (void) {

	return yyparse ( );
}

int yywrap(void)
{
	return 1;
}

void yyerror(char *s) 
{
	fprintf (stderr, "%s \n", s);
} 
