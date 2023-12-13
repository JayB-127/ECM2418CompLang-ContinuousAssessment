main :-
    generator4(X), tester4(X), write(X).

generator4(X) :-
    between(1, 9999, P),
    prime(P),
    toDigits(P, L),
    unique(L),
    insertList(L, [], X).

% predicate that uses recurrence to add new prime list until length list is 10

divisible(X, Y) :-
    0 is X mod Y.
divisible(X, Y) :-
    X > Y+1,
    divisible(X, Y+1).

prime(2) :-
    true.
prime(X) :-
    \+ (divisible(X, 2)).

% converts int to list of digits
toDigits(X, [X]) :-
    X < 10.
toDigits(X, XS) :-
    X >= 10,
    div_mod(X, 10, D, M),
    toDigits(D, R),
    append(R, [M], XS).

% divides and mods two numbers
div_mod(A, B, D, M) :-
    D is A div B,
    M is A mod B.

nub([], []).
nub([X|XS], L) :-
    member(X, XS),
    nub(XS, L).
nub([X|XS], [X|L]) :-
    \+ member(X, XS),
    nub(XS, L).

% finds length of list
listLength([], 0).
listLength([_|XS], N) :-
    listLength(XS, N1),
    N is N1 + 1.

unique(X) :-
    nub(X, Y),
    listLength(Y) == listLength(X).

insertList(E, [], [E]).
insertList(E, [X|XS], [E, X|XS]).



