%{
#include"y.tab.h"
extern yylval;
%}
alpha [A-Za-z]
digit [0-9]
%%

[ \t\n]
drop		return DROP;
alter		return ALTER;
create		return CREATE;
database	return DATABASE;
delete          return DELETE;
update          return UPDATE;
set		return SET;
modify		return MODIFY;
add		return ADD;
"not null"	return NUL;
"primary key"	return PRI;
"foreign key"	return FKEY;
"references"	return REFERENCES;
CHAR|VARCHAR|BOOLEAN|SMALLINT|INT|DECIMAL|NUMERIC|REAL|FLOAT|DOUBLE|DATE  return DATATYPE;
column		return COLUMN;
table		return TABLE;
select            return SELECT;
distinct         return DISTINCT;
from             return FROM;
where           return WHERE;
like               return LIKE;
desc              return DESC;
asc                return ASC;
"group by"    return GROUP;
having          return HAVING;
"order by"    return ORDER;
or                 return OR;
and               return AND;
{digit}+       return NUM;
{alpha}({alpha}|{digit})* return ID;
"<="             return LE;
">="             return GE;
"=="             return EQ;
"!="              return NE;
.                   return yytext[0];

%%
