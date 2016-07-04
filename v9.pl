% How old is Beth?
% In 2 years she will be twice as much as 5 years ago.
puzzle_beth(X) :-
    X + 2 #= 2 * (X - 5).

% A is 2 years older than B.
% B is twice as much as C.
% Together they are 27.
puzzle_abc(A, B, C) :-
    A #>= 0, B #>= 0, C #>= 0,
    A #= B + 2,
    B #= C * 2,
    A + B + C #= 27,
    labeling([], [A, B, C]).

% Mum and Son together are 66.
% Mums digits are reversed Sons.
puzzle_momson(M, S) :-
    S #>= 10, M #> S,
    M + S #= 66,
    M // 10 #= S mod 10,
    M mod 10 #= S // 10,
    labeling([], [M, S]).

% A : B = 5 : 4.
% In 3 years: A : B = 11 : 9.
puzzle_ratio(A, B) :-
    A #>= 0, B #>= 0,
    A #=< 200, B #=< 200,
    A * 4 #= B * 5,
    (A + 3) * 9 #= (B + 3) * 11,
    labeling([], [A, B]).

% List S is 3x3.
% S is permutation of numbers 1 to 9.
% Sum in each row is equal to sum in collumn and sum in main diagonals.
magic(S) :-
    S = [A, B, C, D, E, F, G, H, I],
    S ins 1..9,
    all_different(S),
    A + B + C #= D + E + F,
    A + B + C #= G + H + I,
    A + B + C #= A + D + G,
    A + B + C #= B + E + H,
    A + B + C #= C + F + I,
    A + B + C #= A + E + I,
    A + B + C #= C + E + G,
    labeling([], S).

% Find Greatest Common Divisor of X and Y.
gcd(X, Y, GCD) :-
    GCD #>= 0,
    GCD #=< X , GCD #=< Y,
    X mod GCD #= 0,
    Y mod GCD #= 0,
    once(labeling([down], [GCD])).    % Labeling outputs all solutions.
                                      % 'down' option goes from highest to lowest.
                                      % Once executes it just once.

% X is number N in base B (B is inside interval [2, 10]).
tobase(0, _, 0):-!.

tobase(N, B, X) :-
    B in 2..10,
    N #>= 0, indomain(B),
    R #>= 0 , R #< B,
    N #= D * B + R,
    X #= N1 * 10 + R,
    tobase(D, B, N1).
