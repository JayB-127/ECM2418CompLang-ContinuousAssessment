main :-
    generator4(X), write(X).

generator4(XS) :-
    between(0, 999, P),
    prime(P),
    toDigits(P, L),
    unique(L),
    insertLoop(L, [], XS).
           
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



tester4(X) :-
    traverseList(X, XS),
    sort(XS, [], S),
    removeFirst(S, E),
    reverseList(E, _).
    % check if remaining digits can create set of cubes

listToNum(L, N) :-
    listToNum(L, 0, N).
listToNum([], A, A).
listToNum([H|T], A, N) :-
    B is 10*A + H,
    listToNum(T, B, N).

traverseList([], []).
traverseList([L|LS], [X|XS]) :-
    listToNum(L, X),
    traverseList(LS, XS).

sort([],A,A).
sort([H|T],A,Sorted):-
    insert(H,A,NA),
    sort(T,NA,Sorted).
   
insert(X,[Y|YS],[Y|NT]):-
    X>Y,
    insert(X,YS,NT).
insert(X,[Y|YS],[X,Y|YS]):-
    X=<Y.
insert(X,[],[X]).

removeFirst([], []).
removeFirst([_], []).
removeFirst([_|XS], XS).

reverseList([], []).
reverseList([X|XS], W) :-
    reverseList(XS, V),
    append(V, [X], W).

x_tester4(N) :-
    x_tester4_loop(
        [[[8 ,2 ,7] ,[6 ,1] ,[5 ,3] ,[4 ,0 ,9]]
        ,[[8 ,2 ,7] ,[6 ,1] ,[4 ,0 ,9] ,[5 ,3]]
        ,[[8 ,2 ,7] ,[5 ,3] ,[6 ,1] ,[4 ,0 ,9]]
        ,[[8 ,2 ,7] ,[4 ,0 ,9] ,[6 ,1] ,[5 ,3]]
        ,[[6 ,1] ,[8 ,2 ,7] ,[4 ,0 ,9] ,[5 ,3]]
        ,[[6 ,1] ,[4 ,0 ,9] ,[5 ,3] ,[8 ,2 ,7]]
        ,[[5 ,3] ,[6 ,1] ,[4 ,0 ,9] ,[8 ,2 ,7]]
        ,[[5 ,3] ,[4 ,0 ,9] ,[6 ,1] ,[8 ,2 ,7]]
        ,[[4 ,0 ,9] ,[5 ,3] ,[8 ,2 ,7] ,[6 ,1]]
        ,[[4 ,0 ,9] ,[8 ,2 ,7] ,[6 ,1] ,[5 ,3]]], 0, N).

x_tester4_loop([], C, C).
x_tester4_loop([T|TS], C, N):- 
    tester4(T),
    C1 is C + 1,
x_tester4_loop(TS, C1, N).
x_tester4_loop([_|TS], C, N) :-
x_tester4_loop(TS, C, N).