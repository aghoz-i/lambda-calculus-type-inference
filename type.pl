
:- module(type, [type/3, type_of_expr/2]).
% structure of a lambda calculus:
% - lambda(Var, Expr)
% - app(Expr, Expr)
% - var(X)
% next: add support to primitive type

% lookup(+Variable, +Context, ?Type)
% look up Type of a Variable in given Context
lookup(Var, [Var:Type | _], Type) :- !.
lookup(Var, [_|Context], Type) :-
    lookup(Var, Context, Type).

% type(+Term, +Context, ?Type)
% check/infer Term has type Type in given Context
type(var(X), Context, Type) :-
    lookup(X, Context, Type).
type(lambda(var(X), Body), Context, A -> B) :-
    type(Body, [X:A|Context], B).
type(app(N,M), Context, B) :-
    type(N, Context, A -> B),
    type(M, Context, A).

:- use_module(parse).

type_of_expr(ExprInAtomForm, Type) :- atom_to_lc(ExprInAtomForm, Expr), type(Expr, [], Type).
