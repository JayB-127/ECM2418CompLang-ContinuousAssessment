main :-
    generator4(X), tester4(X), write(X).

% generator: check N is a valid set of prime runs of the right length, using digits 0 to 9


generator4(LS) :-
    primes(P),
    insert(P, [], LS).

insert(E, [], [E]).
insert(E, L, [[E], L]) :-
    listLength(L, W),
    W =< 10.
insert(_, L, L) :-
    listLength(L, W),
    W > 10,
    !.

primes(P) :-
    between(1, 9999, P),
    prime(P),
    unique(P).


% checks if number is divisible by another
divisible(X, Y) :-
    0 is X mod Y.
divisible(X, Y) :-
    X > Y+1,
    divisible(X, Y+1).

% checks if number is prime
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

% removes duplicates from list
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

% checks if a list contains duplicates
unique(X) :-
    toDigits(X, L),
    nub(L, Y),
    listLength(Y) == listLength(L).

% inserts list into list
insertList(E, [], [E]).
insertList(E, [X|XS], [E, X|XS]).



