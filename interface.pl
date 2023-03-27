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