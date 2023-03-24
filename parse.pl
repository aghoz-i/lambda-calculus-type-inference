% tokenize and parse a string/atom to a lambda expression

% current lambda expresion structure is consisted of
% lambda(Var, Expr) for abstraction
% app(Expr, Expr) for application
% var(X) for variables

% lambda calculus BNF:
% <expr> ::= <var> | <lambda> <var> '.' <expr> | '(' <expr> ')' | <expr> <expr> ; currently left recursive need to be adjusted to be acceptable in DCG
% <var> ::= [a-z][0-9]*
% <lambda> ::= '\' | ''λ'
