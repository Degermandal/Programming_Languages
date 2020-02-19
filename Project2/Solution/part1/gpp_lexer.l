%{
%}

DIGIT            [0-9]
LETTER           [a-zA-Z]
IDENTIFIER        {LETTER}|{DIGIT}|"_"
COMMENT          ;.*{NEWLINE}
STRING           \"{print}*\"
IDENT           _{IDENTIFIER}*|{LETTER}{IDENTIFIER}*
INT              {DIGIT}+|\+{DIGIT}+|\-{DIGIT}+

%%


"and"                   {
                                printf("KW_AND\n");
                        }

"or"                    {
                                printf("KW_OR\n");
                        }

"not"                   {
                                printf("KW_NOT\n");
                        }

"equal"                 {
                                printf("KW_EQUAL\n");
                        }

"less"                  {
                                printf("KW_LESS\n");
                        }

"nil"                   {
                                printf("KW_NIL\n");
                        }

"list"                  {
                                printf("KW_LIST\n");
                        }

"append"                {
                                printf("KW_APPEND\n");
                        }

"concat"                {
                                printf("KW_CONCAT\n");
                        }

"set"                   {
                                printf("KW_SET\n");
                        }

"deffun"                {
                                printf("KW_DEFFUN\n");
                        }

"for"                   {
                                printf("KW_FOR\n");
                        }

"if"                    {
                                printf("KW_IF\n");
                        }

"exit"                  {
                                printf("KW_EXIT\n");
                        }                       

"load"                  {
                                printf("KW_LOAD\n");
                        }

"disp"                  {
                                printf("KW_DISP\n");
                        }

"true"                  {
                                printf("KW_TRUE\n");
                        }

"false"                 {
                                printf("KW_FALSE\n");
                        }   



"+"                     {
                                printf("OP_PLUS\n");
                        }

"-"                     {
                                printf("OP_MINUS\n");
                        }

"*"                     {
                                printf("OP_MULT\n");
                        }

"/"                     {
                                printf("OP_DIV\n");
                        }

"("                     {
                                printf("OP_OP\n");
                        }

")"                     {
                                printf("OP_CP\n");
                        }

"**"                    {
                                printf("OP_DBLMULT\n");
                        }

"\""                    {
                                printf("OP_OC/CC\n");
                        }

","                     {
                                printf("OP_COMMA\n");
                        }


";;"                    {
                                printf("COMMENT\n");
                        }

{DIGIT}                 {
                                printf("DIGIT\n");    
                        }

{LETTER}                {
                                printf("LETTER\n");  
                        }

{IDENTIFIER}            {
                                printf("IDENTIFIER\n");  
                        }

{IDENT}                 {
                                printf("IDENT\n");
                        }

{INT}                   {
                                printf("INT\n");
                        }
                                

%%

int yywrap(){} 

int main(int argc, char **argv) 
{ 
        yylex(); 
        return 0; 
}
