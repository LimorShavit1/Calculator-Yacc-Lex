%{
 #include <stdio.h>
 #include <math.h>
int yylex();
int yyerror();
%}

%union {
                float fval;
                int ival;
}
%token <fval> NUMBER
%type <fval> expression

%token POWER
%token SIN 
%token COS
%token TAN
%token SQRT
%token LOG2
%token LOG10
%token PI
%token E

%left '+' '-'
%left '*' '/' '%' 
%left POWER
%left DEV_2


%start	statement_list
%%

statement_list:	statement '\n'
              | statement_list statement '\n'
			  ;

statement:   expression{ printf("= %.4f\n",$1); }
 ;

expression: expression '+' expression {$$ = $1 + $3; }
          | expression '-' expression {$$ = $1 - $3; }
          | expression '*' expression {$$ = $1 * $3; }
          | expression '/' expression { 
                                                    if($3==0)
                                                         {
                                                              printf("Error! Divide By Zero.\n");
                                                          }
                                                      else $$ = $1 / $3;
                                                     }
          | expression '%' expression  {
                                                        if($3==0)
                                                         {
                                                              printf("Error! Divide By Zero.\n");
                                                          }
                                                      $$ = (int)$1 % (int)$3; 
                                                     }
          | expression DEV_2 expression {
                                                        if($3==0)
                                                         {
                                                              printf("Error! Divide By Zero.\n");
                                                          }
                                                      $$ = (int)$1 / (int)$3; 
                                                     }
          | SIN'('expression')'  { $$=sin($3);}
          | COS'('expression')'  { $$=cos($3);}
          | TAN'('expression')'  { $$=tan($3);}
          | SQRT'('expression')'  { $$=sqrt($3);}
          | PI  { $$=M_PI;}
          | E {$$=((double)M_E);}
          | LOG2'('expression')' {$$=log2($3);}
          | LOG10'('expression')' {$$=log10($3);}
          |'('expression')'  { $$=$2;}
          | expression POWER expression {$$ = pow($1,(int)$3); }
		  | NUMBER
			  ;

%%
int main() {
                printf("w4.yacc\n");
	return yyparse();
}

int yyerror() {
	printf("Error\n");
	return 0;
}