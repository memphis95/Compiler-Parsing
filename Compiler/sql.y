%{
#include <stdio.h>
#include <stdlib.h>
#include<ctype.h>
int flag=0;
%}
%token ID NUM SELECT DISTINCT FROM WHERE LE GE EQ NE OR AND LIKE GROUP HAVING ORDER ASC DESC DROP TABLE COLUMN ALTER MODIFY DATATYPE ADD DELETE UPDATE SET
%token CREATE DATABASE NUL PRI FKEY REFERENCES
%right '='
%left AND OR
%left '<' '>' LE GE EQ NE

%%

    S         : ST1';' {printf("INPUT ACCEPTED.... \n\t\t...mysql compiler\n");flag=1;exit(0);};
    		;
    ST1     : SELECT attributeList FROM tableList ST2
               | SELECT DISTINCT attributeList FROM tableList ST2
               | DROP DATABASE ID
               | DROP TABLE ID 
               | ALTER TABLE ID DROP ID
               | ALTER TABLE ID DROP COLUMN ID
               | ALTER TABLE ID MODIFY COLUMN ID DATATYPE
               | ALTER TABLE ID ADD COLUMN ID DATATYPE
               | CREATE DATABASE ID
               | CREATE TABLE ID '(' COLUMN_LIST FOREIGN_KEY')'
               | DELETE FROM ID WHERE COND
               | UPDATE ID SET ID '=' F VAL WHERE COND
               ;
    VAL     : ',' ID '=' F VAL
               |
               ;
    ST2     : WHERE COND ST3
               | ST3
               ;
    ST3     : GROUP attributeList ST4
               | ST4
               ;
    ST4     : HAVING COND ST5
               | ST5
               ;
    ST5     : ORDER attributeList ST6
               |
               ;
    ST6     : DESC
               | ASC
               |
               ;
  COLUMN_LIST  :
  		| ID DATATYPE '(' NUM ')' NOT_NULL PRIMARY',' COLUMN_LIST 
  	       | ID DATATYPE '(' NUM ')' NOT_NULL PRIMARY
  	       ;
  PRIMARY	:
  		| PRI
  		;
  NOT_NULL	:
  		|NUL
  		;
  FOREIGN_KEY	:
  		| FKEY '(' ID ')' REFERENCES ID '(' ID ')'
  		;
  attributeList :     ID','attributeList
               | '*'
               | ID
               ;
 tableList    : ID',' tableList
               | ID
               ;
    COND    : COND OR COND
               | COND AND COND
               | E
               ;
    E         : F '=' F
               | F '<' F
               | F '>' F 
               | F LE F
               | F GE F
               | F EQ F
               | F NE F
               | F OR F
               | F AND F
               | F LIKE F
               ;
    F         :'\'' ID '\''
               |ID
               | NUM 
               ;

%%

main()
{
    printf("Enter the query:");
    yyparse();
    if(flag==0)
    printf("Invalid!");
}
void yyerror(char *err){
fprintf(stderr, "%s\n",err);
}
