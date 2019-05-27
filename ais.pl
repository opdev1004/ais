/*
It prints list. It recursively goes through each atom. write "." and "?" without space; " ".
*/
printSentence([]).
printSentence([qm]):-write("?"), !.
printSentence([.]):-write("."), !.
printSentence([H|T]):-write(" "), write(H), printSentence(T).

/*
answer/2 make use of other predicates, match/2 and transform/2
*/
answer(Input, Ouput):-match(Input, Ouput).

/*
for finding keywords in input lists
It finds certain keyword and fill the output.
It recursively goes through each atom for finding "?"
match([H|T], Output):-(H=i; H='my'),... is easy to extend by adding extras. eg. H="he"; H="she"
*/
match([], ["sorry,", i, do, not, "understand.", can, you, ask, something, else, qm]):-!.
match([H|T], Output):-(H=i; H='my'), transform([H|T], Output), !.
match([you|_], [let, us, not, talk, about, me, .]):-!.
match([H|_], [do, nightmares, frighten, you, qm]):-(H = nightmare; H = nightmares), !.
match([?|[]], [why, do, you, ask, qm]):-!.
match([_|T], Output) :- match(T, Output).


/*
for transforming input phrases into the corresponding output fragments
It uses other predicates to convert and add question mark.

*/
transform([i,am|T], [why, are, you|Output]):-convert(T, ConvertedResult), append(ConvertedResult, [qm], Output), !.
transform([i,was|T], [why, were, you|Output]):-convert(T, ConvertedResult), append(ConvertedResult, [qm], Output), !.
transform([i,can|T], [why, can, you|Output]):-convert(T, ConvertedResult), append(ConvertedResult, [qm], Output), !.
transform([i,will|T], [why, will, you|Output]):-convert(T, ConvertedResult), append(ConvertedResult, [qm], Output), !.
transform([i,Word|T], [are, you, sure, you, cannot|Output]):-(Word = cannot; Word = "can't"; Word = cant), convert(T, ConvertedResult), append(ConvertedResult, [qm], Output), !.
transform([my, Object|T], [why, your, Object|Output]):-convert(T, ConvertedResult), append(ConvertedResult, [qm], Output), !.
transform([i,feel|T], [what, makes, you, feel|Output]):-convert(T, ConvertedResult), append(ConvertedResult, [qm], Output), !.
transform([i,fantasised|T], [have, you, ever, fantasised|Output]):-convert(T, ConvertedResult), append(ConvertedResult, [before, qm], Output), !.

/*
predicates for helping match/2 and transform/2.
It recursively go through each atom and convert i/my/me/am/was/your/you for understandable conversion.
It is written on the assumption that this will only be between "I" and "You"
*/
convert([], []).
convert([i|T], [you|Output]):-convert(T, Output), !.
convert([my|T], [your|Output]):-convert(T, Output), !.
convert([me|T], [you|Output]):-convert(T, Output), !.
convert([am|T], [are|Output]):-convert(T, Output), !.
convert([was|T], [were|Output]):-convert(T, Output), !.
convert([your|T], [my|Output]):-convert(T, Output), !.
convert([you|T], [me|Output]):-convert(T, Output), !.
convert([H|T], [H|Output]):-convert(T, Output).

printReply(Input) :- answer(Input, Output), printSentence(Output).
