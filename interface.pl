:- module(interface, [main/0]).

:- use_module(library(pce)).
:- use_module(type).

ask_input(Input) :-
        new(D, dialog('Input')),
        send(D, append, new(InputItem, text_item(input))),
        send(D, append, button(ok, message(D, return, InputItem))),
        send(D, append, button(cancel, message(D, return, cancel))),
        send(D, default_button(ok)),
        get(D, confirm, Rval),
        free(D),
        Rval \== cancel,
        get(Rval, selection, Text),
        Input = Text.

main :-
    new(D, dialog('Lambda Calculus Inference')),
    send(D, append, new(Text, label)),
    send(D, append, new(Input, text_item('input expression'))),
    send(D, append, button(ok, message(@prolog, display, Text, Input?selection))),
    send(D, open).

display(TextBox, Text) :-
    type_of_expr(Text, Type),
    format(atom(Formatted), "~w", [Type]),
    send(TextBox, selection, Formatted).
