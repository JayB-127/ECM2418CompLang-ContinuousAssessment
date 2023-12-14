main :-
    generator4(X), write(X).

generator4(XS) :-
    between(0, 999, P),
    prime(P),
    toDigits(P, L),
    unique(L),
    insertList(L, [], LS),
    insertLoop(L, LS, XS).
           
primes(P) :-
	between(0, 999, P),
    prime(P),
    toDigits(P, L),
    unique(L).

insertLoop(_, L, L) :-
    listLength(L, W),
    W >= 10.
insertLoop(E, L, LS) :-
    listLength(L, W),
    W < 10,
    insertList(E, L, XS),
    insertLoop(E, XS, LS).
    

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
    nub(X, Y),
    listLength(Y) == listLength(X).

% inserts list into list
insertList(E, [], [E]).
insertList(E, [X|XS], [E, X|XS]).
