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