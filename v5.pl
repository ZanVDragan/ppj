% Count appearances of X in List.
count(_, [], 0).        % Base case with empty List.

%count(X, [H|T], N) :-    % Divide the List into Header and Tail.
%    count(X, T, NT),     % Continue counting with Tail.
%    (X = H, !,           % Check if X is equal to Head.
%    N is NT + 1;         % If so, add 1 to N and prevent searching in else branch.
%    N = NT).             % Else assign NT to N.

% Better with negation (opposed to cut).
count(X, [H|T], N) :-
    count(X, T, NT),
    (X = H, N is NT + 1;
    X \= H, N = NT).        % Check if X is not equal to Head. If so assign NT to N.

% Create union of two Lists.
union([], S2, S2).

union([H|T], S2, U) :-
    union(T, S2, UTS2),                % Recursive call to union with Tail of first and new Union.
    (\+memb(H, UTS2), U = [H|UTS2];    % If Head is not a member of new Union, add it;
    memb(H, UTS2), U = UTS2).          % Else if Head is a member set Union to new Union.

% You can use multiple definitions instead of an OR clause.
% union([H|T], S2, U) :-
%    memb(H, S2),
%    union(T, S2, U).
% union([H|T], S2, [H|U]) :-
%    \+memb(H, S2),
%    union(T, S2, U).

% Get Intersect of two Lists.
intersect([], _, []).

intersect([H|T], S2, I) :-
    intersect(T, S2, R),        % Recursive call with Tail and current Result.
    (memb(H, S2), I = [H|R];    % If a member of the second List, add to the final List;
    \+memb(H, S2), I = R).      % Else if not a member of the second List,
                                % set the final List as current Result.

% Get all differences between two Lists.
diff([], _, []).    % Base case with an empty List.

diff([H|T], S2, D) :-          % Divide the first List into Head and Tail.
    diff(T, S2, R),            % Recusrive call to get differences with Tail.
    (\+memb(H, S2), D = [H|R]; % If not member, add to final List,
    memb(H, S2), D = R).       % Else if member, set final List as current.

% Check if first List is superset of second.
is_superset(_, []).    % Base case of and empty List.

is_superset(S1, [H|T]) :-    % Divide the second List into Head and Tail.
    is_superset(S1, T),      % Recursive call to check if superset of Tail.
    memb(H, S1).             % Check if Head is a member of the first List.

% Check if first List is subset of second.
is_subset([], _).    % Base case with an empty List.

is_subset([H|T], S2) :-    % Divide the first List into Head and Tail.
    is_subset(T, S2),      % Recursive call to check if Tail is a subset.
    memb(H, S2).           % Check if Head is a member of the second List.

%is_subset(S1, S2) :-
%    is_superset(S2, S1).    % Same as reversed superset.

% Get all subsets of given List.
subset([], []).    % Base case with an empty List.

subset([H|T], SS) :-    % Divide the List into Head and Tail.
    (SS = [H|SS1];      % Set result to concatenation of Head and current Subset.
    SS = SS1),          % Set result to current Subset.
    subset(T, SS1).     % Get subset from Tail.

% Find powerset of given List.
powerset(S, PS) :-
    findall(SS, subset(S, SS), PS). % Find all solutions of a subset.

% findall(template, goal, result).
% findall(X, memb(X, [1, 2, 3]), L).
%    L = [1, 2, 3].
% findall(X/Y, (memb(X, [1, 2, 3]), memb(Y, [1, 2, 3])), L).
%    L = [1/1, 1/2, 1/3, 2/1, ...].
