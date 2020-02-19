%{
    #include "y.tab.h"

%}


value       [-]*[1-9]+[0-9]* {yylval = atoi(yytext); return VAL;}
identifier  [a-zA-Z]+[0-9]*   = {return ID;}

comment     [;;]+  ///?????????????????????????



and       {return AND;}
or        {return OR;}
not       {return NOT;}
equal     {return EQUAL;}
append    {return APPEND;}
concat    {return CONCAT;}
set       {return SET;}
deffun    {return DEFFUN;}
for		  {return FOR;}
if        {return IF;}
exit      {return EXIT;}
less      {return LESS;}
nil       {return NIL;}
list      {return LIST;}
load      {return LOAD;}
disp      {return DISP;}
true      {return TRUE;}
false     {return FALSE;}




%%

