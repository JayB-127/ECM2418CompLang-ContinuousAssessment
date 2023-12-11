main :-
    generator3(_).

% generates perfect squares from 1000 to 1000000
generator3(X) :-
    between(1000, 1000000, X),
    square(X).

% checks if a number is a perfect square
square(X) :-
    floor(sqrt(X))^2 =:= X.




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