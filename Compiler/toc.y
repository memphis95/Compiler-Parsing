%{#include<stdio.h>
%}
%token db insertOne insertMany find updateOne updateMany deleteOne deleteMany drop
%token limit count sort
%token OP1 OP2 OP SETOP UNSETOP
%token '{' '}' ',' ':' 
%token '0' '1' '-' _id 
%token ID NUMBER DECIMAL
%%
MongoDBStatement: CreateStatement
	| FindStatement
	| UpdateStatement
	| DeleteStatement
	| DropStatement
	;

CreateStatement: db '.' COLLECTION '.' insertMany '(' DOCUMENT_LIST ')'
	| db '.' COLLECTION '.' insertOne '(' DOCUMENT ')' 
	;
DOCUMENT_LIST: DOCUMENT_LIST ',' DOCUMENT
	| DOCUMENT
	;
DOCUMENT: '{' FIELD_LIST '}'
	;
FIELD_LIST: FIELD_LIST ',' FIELD ':' VALUE
	| FIELD ':' VALUE
	| FIELD_LIST ',' FIELD ':' '{' FIELD_LIST '}'
	;
COLLECTION: ID
	;
FIELD: ID
	;
VALUE: '"' ID '"'
	| NUMBER
	| DECIMAL
	;

FindStatement: db '.' COLLECTION '.' find '(' QUERY_CRITERIA PROJECTION ')' FUNCTION
	;
QUERY_CRITERIA: '{' CONDITION_LIST '}'
	| '{' FIELD_LIST '}'
	| '{' '}'
	;
CONDITION_LIST: CONDITION_LIST ',' CONDITION
	| CONDITION
	;
CONDITION: FIELD ':' '{' OPERATOR_LIST '}'
	| OP ':' '[' '{' CONDITION_LIST '}' ']'
	| OP ':' '[' '{' FIELD_LIST '}' ']'
	| OP ':' '[' '{' CONDITION_LIST '}' ',' '{' FIELD_LIST '}' ']'
	| OP ':' '[' '{' FIELD_LIST '}' ',' '{' CONDITION_LIST '}' ']'
	;
OPERATOR_LIST: OPERATOR_LIST ',' OPERATOR 
	| OPERATOR
	;
OPERATOR: OP1 ':' NUMBER
	| OP2 ':' '[' VALUE_LIST ']'
	;
VALUE_LIST: VALUE_LIST ',' VALUE
	| VALUE
	;
PROJECTION:  
	| ',' '{' INCLUSION_LIST '}'
	;
INCLUSION_LIST: INCLUSION_LIST ',' INCLUSION 
	| INCLUSION
	;
INCLUSION: FIELD ':' '0'
	| FIELD ':' '1'
	| _id ':' '0'
	;
FUNCTION:
	| '.' limit '(' NUMBER ')'
	| '.' count '(' ')'
	| '.' sort '(''{' ORDER_LIST '}' ')'
	;
ORDER_LIST: ORDER_LIST ',' ORDER
	| ORDER
	;
ORDER: FIELD ':' '1'
	| FIELD ':' '-' '1'
	;

UpdateStatement: db '.' COLLECTION '.' updateOne '(' QUERY_CRITERIA ',' UPDATE ')'
	| db '.' COLLECTION '.' updateMany '(' QUERY_CRITERIA ',' UPDATE ')'
	;
UPDATE: '{' SETOP ':' '{' FIELD_LIST '}' '}'
	| '{' UNSETOP ':' '{' UNFIELD_LIST '}' '}'
	;
UNFIELD_LIST: UNFIELD_LIST ',' FIELD ':' '"' '"'
	| FIELD ':' '"' '"'
	;
	
DeleteStatement: db '.' COLLECTION '.' deleteOne '(' QUERY_CRITERIA ')'
	| db '.' COLLECTION '.' deleteMany '(' QUERY_CRITERIA ')'
	;

DropStatement: db '.' COLLECTION '.' drop '(' ')'
	;
%%
int main()
{
	printf("\n Enter a MongoDB Statement: ");
	if(yyparse()==0)
		printf("\n Parsing Complete! ");
	return 0;
}

void yyerror()
{
	printf("\n Parsing Failed! ");
}
	
