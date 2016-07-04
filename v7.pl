% number(X) <--- check if X is number
% integer(X) <--- check if X is integer
% float(X) <--- check if X is float
% atom(X) <--- check if X is atom
% atomic(X) <--- check if X is non structured type
% coumpound(X) <--- check if X is structured type
% var(X) <--- check if X is not yet defined
% nonvar(X) <--- check if X is defined

% Get List of digits from given list.
getdigits([], []).

getdigits([H|T], LD) :-
    getdigits(T, LD1),        % Recursively search for digits.
    (number(H), LD = [H|LD1]  % Check if current Head is number and store it.
    ;
    \+number(H), LD = LD1).   % If current Head is not a number, keep the List.

% Recursively build Digits that are given in List.
joindigits([], []).

joindigits([H1, H2|T], NL) :-
    Num is H1 * 10 + H2,        % Join first two Digits.
    joindigits([Num|T], NL).    % Build List with new Digits.

joindigits([H|T], [H|NLT]) :-   % Go through all options of Lists.
    joindigits(T, NLT).

firstMinus([H|T], [-H|T]).    % Return List with first Element negated.
firstMinus(L, L).             % Return List without first Element negated.

% Generate valid expressions from List.
genexp([E], E).    % Base case with one Element.

genexp(L, Exp) :-
    conc(Before, [H1, H2|After], L),    % Get two Elements from anywhere in the List.
    memb(Op, ['+', '-', '*', '/']),     % Get every possible operator.
    Tmp =.. [Op,H1,H2],                 % Create a Functor with Operator and two Elements.
    conc(Before, [Tmp|After], L1),      % Insert created Functor anywhere in the List.
    genexp(L1, Exp).                    % Further develop partial expression (current List).

% Generate all valid expression from given license plate,
% so that E1 = E2.
checkLicensePlate(LP, E1, E2) :-
    getdigits(LP, DL),    % Get Digits from the List.
    joindigits(DL, JDL),  % Generate proper numbers from the List.
    conc(L1, L2, JDL),    % Distribute joined numbers between two Lists.
    firstMinus(L1, ML1),  % Try inserting minus on the first number in first List.
    firstMinus(L2, ML2),  % Try inserting minus on the second number in second List.
    genexp(ML1, E1),      % Generate first expression.
    genexp(ML2, E2),      % Generate second expression.
    E1 =:= E2.            % Evaluate whether they are in fact arithmetically equal.
