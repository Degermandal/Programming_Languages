%{
    #include <stdio.h>
    #include <string.h>
    void yyerror(const char *);
    int yylex();
%}


%token VAL
%token ID

%token AND
%token OR
%token NOT
%token EQUAL
%token APPEND
%token CONCAT
%token SET
%token DEFFUN
%token FOR
%token IF
%token EXIT
%token LESS
%token NIL
%token LIST
%token LOAD
%token DISP
%token TRUE
%token FALSE




%%
START   :   INPUT{
            fprintf(stderr, "start-> input\n");
        }
        ;

INPUT   :   EXPI{
            fprintf(stderr, "input-> expi\n");
            $$ = $1;
        }
        |   EXPLISTI{
            fprintf(stderr, "input-> explisti\n");
            $$ = $1;
        }
        ;

EXPLISTI :   '(' CONCAT EXPLISTI EXPLISTI ')'{
                fprintf(stderr, "explisti-> concat explisti explisti\n");
                fprintf(stderr,"%p %p %p\n", $1, $2, $3 );
         }
         |   '(' APPEND EXPI EXPLISTI ')'{
                fprintf(stderr, "explisti-> append expi explisti\n");
                fprintf(stderr,"%p %p %p\n", $1, $2, $3 );
         }
         |    LISTVALUE{
                fprintf(stderr, "explisti->listvalue\n");
         }
         |   '(' NIL ')'{
                fprintf(stderr, "explisti->nil\n");
         }
         ;

LISTVALUE :  '(' VAL ')'{
                fprintf(stderr, "Listvalue-> val\n");
                fprintf(stderr,"%p \n", $2 );
            }

            |  '(' ')'{
                fprintf(stderr, "listvalue-> ()\n");
            }
            | '(' NIL ')'{
                fprintf(stderr, "listvalue-> nil\n");
            }
          ;

EXPI     :     '(' SET ID EXPI ')'{
                fprintf(stderr, "expi-> set id expi\n");
                fprintf(stderr,"%p %p %p\n", $2, $3, $4 );
            }   
            |'(' ID ')' {
                fprintf(stderr, "expi -> id\n");
                fprintf(stderr,"%p\n", $2);
            }
            | '(' ID EXPLISTI ')'{
                fprintf(stderr, "expi -> id explisti\n");
                fprintf(stderr,"%p %p\n", $2, $3);
            }
            | '(' VAL ')'{
                fprintf(stderr, "expi -> val\n");
                fprintf(stderr,"%p \n", $2);
            }
            ;
/*
EXPI     :  '(' DEFFUN ID IDLIST EXPLISTI ')'{
                fprintf(stderr, "expi -> deffun id idlist explisti\n");
                fprintf(stderr,"%p %p %p %p\n", $2, $3, $4, $5);
            }
            ;
*/



EXPI    :  VAL{
            fprintf(stderr,"EXPI-->number\n");
        }
        |   ID {
            fprintf(stderr,"EXPI-->ID\n");
        }
        |   NUMOP {
            fprintf(stderr,"calculation\n");
        }
        ;

// calculator
NUMOP  :   '(' '+' EXPI EXPI ')'{
            fprintf(stderr,"plus\n");
            $$ = $3 + $4;
            fprintf(stderr,"%p %p %p\n", $$, $3, $4);
        }
        |   '(' '-' EXPI EXPI ')'{
            fprintf(stderr,"minus\n");
            $$ = $3 - $4;
            fprintf(stderr,"%p %p %p\n", $$, $3, $4);
        }
        |   '(' '*' EXPI EXPI ')'{
            fprintf(stderr,"mul\n");
            $$ = $3 * $4;
            fprintf(stderr,"%p %p %p\n", $$, $3, $4);
        }
        |   '(' '/' EXPI EXPI ')'{
            fprintf(stderr,"divide\n");
            $$ = $3 / $4;
            fprintf(stderr,"%p %p %p\n", $$, $3, $4);;
        }
        ;
EXPB :   '(' AND EXPB EXPB ')'{
                fprintf(stderr,"and\n");
                $$ = $3 & $4;
                fprintf(stderr,"%p %p %p\n", $$, $3, $4);
            }
            |   '('  OR EXPB EXPB ')'{
                fprintf(stderr,"or\n");
                $$ = $3 | $4;
                fprintf(stderr,"%p %p %p\n", $$, $3, $4);
            }
            |   '(' NOT EXPB ')'{
                fprintf(stderr,"not\n");
                $$ = !$3;
                fprintf(stderr,"%p %p\n", $$, $3);
            }
            ;

%%


void yyerror(const char *msg) {
    fprintf(stdout, "Syntax Error\n");
}
int main(int argc, char const *argv[]) {
    yyparse();
    return 0;
}
