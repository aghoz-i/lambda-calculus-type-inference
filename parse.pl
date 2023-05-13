% tokenize and parse a string/atom to a lambda expression

% current lambda expresion structure is consisted of
% lambda(Var, Expr) for abstraction
% app(Expr, Expr) for application
% var(X) for variables

% lambda calculus BNF:
% <expr> ::= <var> | <lambda> <var> '.' <expr> | '(' <expr> ')' | <expr> <expr> ; currently left recursive need to be adjusted to be acceptable in DCG
% <var> ::= [a-z][0-9]*
% <lambda> ::= '\' | ''λ'

% \s z -> (s z) === (a -> a) -> a -> a

'C'('λ', [X|L], '.', L).

parse(X, Remain) :- var(X, Remain).
parse(X, Remain) :- var(X, X1), 'C'(λ, X1, ., X2), parse(X2, Remain).
parse(X, Remain) :- var(X, X1), 'C'(\, X1, ., X2), parse(X2, Remain).
var([X|Remain], Remain) :- var(X).

expr(Z) --> expr1(X), app_tail(X, Z).
expr(Lambda) --> abs_parser(Lambda).
expr1(Var) --> var_parser(Var).
expr1(Expr) --> paren_expr(Expr).

paren_expr(Expr) --> ['('], expr(Expr), [')'].

var_parser(var(Token)) --> [Token], {valid_variable(Token)}.
valid_variable(Token) :- atom_chars(Token, [C|Nums]), char_type(C, alpha), maplist(is_digit, Nums).
abs_parser(lambda(Var, Body)) -->['\\'], var_parser(Var), ['.'], expr(Body).

app_tail(Expr, Expr) --> {true}.
app_tail(Function, Expr) --> expr1(Argument), app_tail(app(Function, Argument), Expr).