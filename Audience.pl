main :-
    generator3(X), tester3(X), write(X).

% generates perfect squares from 1000 to 1000000
generator3(X) :-
    between(1000, 1000000, X),
    square(X).

% finds possible numbers from generated list
tester3(X) :-
    toDigits(X, XS),
    unique(XS),
    lastElem(XS, E),
    listLength(XS, N1),
    E == N1,
    secondLastElem(XS, N2),
    isOdd(N2),
    member(0, XS).

% checks if a number is a perfect square
square(X) :-
    floor(sqrt(X))^2 =:= X.

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

% checks a list of int is unique
unique(X) :-
    sort(X, S),
    listLength(X, Y),
    listLength(S, Z),
    Y == Z.

% finds length of list
listLength([], 0).
listLength([_|XS], N) :-
    listLength(XS, N1),
    N is N1 + 1.

% finds last element of list
lastElem([X], X).
lastElem([_|X], Y) :-
    last(X, Y).

% finds second to last element of list
secondLastElem([X,_], X).
secondLastElem([_|XS], X) :-
    secondLastElem(XS, X).

% checks if int is odd
isOdd(X) :-
    \+ (0 is X mod 2).

% checks element is in list
member(X, [X|_]).
member(X, [_|XS]) :-
    member(X, XS).

% generator3 test func
x_generator3(N) :-
    x_generator3_loop(
        [1024, 9409, 23716, 51529
        , 123904, 185761, 868624, 962361
        , 982081, 1000000], 0, N).

x_generator3_loop([], C, C).
x_generator3_loop([T|TS], C, N) :-
    generator3(T),
    C1 is C + 1,
    x_generator3_loop(TS, C1, N).
x_generator3_loop([_|TS], C, N) :-
    x_generator3_loop(TS, C, N).