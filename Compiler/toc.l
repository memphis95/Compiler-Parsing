%{
#include"y.tab.h"
extern yylval;
%}
%%
db	{return db;}
insertOne	{return insertOne;}
insertMany	{return insertMany;}
find	{return find;}
updateOne	{return updateOne;}
updateMany	{return updateMany;}
deleteOne	{return deleteOne;}
deleteMany	{return deleteMany;}
drop	{return drop;}
limit	{return limit;}
count	{return count;}
sort	{return sort;}
$eq|$ne|$gt|$gte|$lt|$lte	{return OP1;}
$in|$nin	{return OP2;}
$or|$and|$not|$nor	{return OP;}
$set	{return SETOP;}
$unset	{return UNSETOP;}


{	{return '{';}
}	{return '}';}

,	{return ',';}
:	{return ':';}

0	{return '0';}
1	{return '1';}
-	{return '-';}
_id	{return _id;}
[_]?[a-zA-Z ]+ {return ID;}
[0-9]+ {yylval=atoi(yytext); return NUMBER;}
[0-9]+.[0-9]+ {yylval=atoi(yytext); return DECIMAL;}
[\t]+ ;
\n {return 0;}
. {return yytext[0];}
%%

