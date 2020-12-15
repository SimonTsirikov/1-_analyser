grammar language;

script: (expression | definition )+ ;

definition: funcdef | procdef ;

funcdef: ('&' directive)? Lfunction Id '(' params ')' Lexport? (expression)* Lreturn rvalue ';' Lendfunction ; 
procdef: ('&' directive)? Lprocedure Id '(' params ')' Lexport? (expression)* (Lreturn)? Lendprocedure ;

params: /* epsilon */ | (param ',')* param ;
param: Lval? Id ('=' rvalue)? ;

expression:
    ('~' Id ':')?
    ( assignment
    | vardecl
    | exception
    | execution
    | handle
    | trycatch
    | forloop
    | foreachloop
    | whileloop
    | condition
    | jump
    | call
    ) ';'
    ;

assignment: lvalue '=' rvalue ;

lvalue: Id (('[' rvalue ']') | ('.' Id))* ;

rvalue: 
      Num
    | Str
    | Date
    | Lundefined
    | bool
    | allocation
    | lvalue
    | call
    | elvis
    | '(' logic ')'
    | '(' arythmetics ')'
    | '(' comparison ')'
    ;

allocation: 
      Lnew call
    | Lnew '(' lvalue ',' args ')' 
    ;

arythmetics:
      rvalue '+' rvalue
    | rvalue '-' rvalue
    | '-' rvalue
    | rvalue '*' rvalue
    | rvalue '/' rvalue
    | rvalue '%' rvalue
    ;

logic: 
      Lnot rvalue
    | rvalue Land rvalue
    | rvalue Lor rvalue
    ;

comparison: 
      rvalue '>' rvalue
    | rvalue '<' rvalue
    | rvalue '=' rvalue
    | rvalue '>=' rvalue
    | rvalue '<=' rvalue
    | rvalue '<>' rvalue
    ;

call: lvalue '(' args ')' ;

args: /* epsilon */ | (rvalue ',')* rvalue ;

elvis: '?' '(' rvalue ',' rvalue ',' rvalue ')' ;

vardecl: Lvar (Id Lexport? ',')* Id Lexport? ;

exception: Lraise rvalue ;

execution: Lexecute '(' Str ')' ;

handle: 
      Laddhandler lvalue ',' lvalue
    | Lremovehandler lvalue ',' lvalue
    ;

trycatch: Ltry expression+ Lexcept expression+ (Lraise ';')? Lendtry ;

forloop: Lfor Id '=' rvalue Lto rvalue Ldo (expression | ((Lbreak | Lcontinue) ';'))* Lenddo ;

foreachloop: Lfor Leach Id Lin rvalue Ldo (expression | ((Lbreak | Lcontinue) ';'))* Lenddo ;

whileloop: Lwhile rvalue Ldo (expression | ((Lbreak | Lcontinue) ';'))* Lenddo ;

condition: Lif rvalue Lthen expression* (Lelif rvalue Lthen expression*)* (Lelse expression*)? Lendif ;

jump: Lgoto '~' Id ;



Lif: 'if' | 'если' ;
Lthen: 'then' | 'тогда' ;
Lelif: 'elseif' | 'иначеесли' ;
Lelse: 'else' | 'иначе' ;
Lendif: 'endif' | 'конецесли' ;

Lfor: 'for' | 'для' ;
Leach: 'each' | 'каждого' ;
Lin: 'in' | 'из' ;
Lto: 'to' | 'по' ;
Lwhile: 'while' | 'пока' ;
Ldo: 'do' | 'цикл' ;
Lenddo: 'enddo' | 'конеццикла' ;

Lprocedure: 'procedure' | 'процедура' ;
Lfunction: 'function' | 'функция' ;
Lendprocedure: 'endprocedure' | 'конецпроцедуры' ;
Lendfunction: 'endfunction' | 'конецфункции' ;

Lvar: 'var' | 'перем' ;
Lgoto: 'goto' | 'перейти' ;
Lreturn: 'return' | 'возврат' ;
Lcontinue: 'continue' | 'продолжить' ;
Lbreak: 'break' | 'прервать' ;

Land: 'and' | 'и' ;
Lor: 'or' | 'или' ;
Lnot: 'not' | 'не' ;

Ltry: 'try' | 'попытка' ;
Lexcept: 'except' | 'исключение' ;
Lraise: 'raise' | 'вызватьисключение' ;
Lendtry: 'endtry' | 'конецпопытки' ;
Lnew: 'new' | 'новый' ;
Lexecute: 'execute' | 'выполнить' ;
Laddhandler: 'addhandler' | 'добавитьобработчик' ;
Lremovehandler: 'removehandler' | 'удалитьобработчик' ;

Lnull: 'null' ;
Ltrue: 'true' | 'истина' ;
Lfalse: 'false' | 'ложь' ;
Lundefined: 'undefined' | 'неопределено' ;
	
Lexport: 'export' | 'экспорт' ;
Lval: 'val' | 'знач' ;

directive:
      Latclient
    | Latserver
    | Latserverwithoutcontext
    | Latclientatserver
    | Latclientatserverwithoutcontext
    ;

Latclient: 'atclient' | 'наклиенте' ;
Latserver: 'atserver' | 'насервере' ;
Latserverwithoutcontext: 'atserverwithoutcontext' | 'насерверебезконтекста' ;
Latclientatserver: 'atclientatserver' | 'наклиентенасервере' ;
Latclientatserverwithoutcontext: 'atclientatserverwithoutcontext' | 'наклиентенасерверебезконтекста' ;

Id: [a-zа-я_] [a-zа-я0-9_]* ;
Num: ('-' | '+')? [0-9]+ ('.' [0-9]+)? ;
Str: '"' ([-a-zа-я0-9_:/.!,?() ] | ('\n' '|'))* '"' ;
Date: '\'' [0-9] [0-9] [0-9] [0-9] ('0' [1-9] | '1' [0-2]) (('0' [1-9]) | ([1-2] [0-9]) | ('3' [0-1])) (('0' [0-9]) | ('1' [0-9]) | ('2' [0-3])) ([0-5] [0-9]) ([0-5] [0-9]) '\'' ;
bool: Ltrue | Lfalse ;

COMMENT: '//' [-a-zа-я0-9_:/!,?(). ]* '\n' -> skip ;
SPACE: (' ' | '\t' | '\n')+ -> skip ;
