% Check if Elements in a List are sorted from low to high.
is_sorted([]).        % Base case of empty List.
is_sorted([E]).       % Base case of one Element.

is_sorted([H1, H2|T]) :-   % Divide List into Head1, Head2 and Tail.
    H1 =< H2,              % Check if Head1 is less than or equal to Head2.
    is_sorted([H2|T]).     % Proceed with Tail and Head2.
                           % (using just Tail would result in skipping
                           % one comparison every two items - e.g. second =< third)

% Sort List from lowest to highest.
%slowest_sort_ever([], []).    % Base case with empty List.

%slowest_sort_ever(L, [Min|SL1]) :-  % Combine Minimum with further iterations.
%    min(L, Min),                    % Find current Minimum.
%    del(Min, L, L1),                % Remove it from the List.
%    slowest_sort_ever(L1, SL1).     % Proceed with the new List.

slowest_sort_ever(L, SL) :-
    permute(L, SL),
    is_sorted(SL).

% Insert Element into sorted List so it remains sorted giving new List.
sins(X, [], [X]).    % Base case if current List is empty just add Element.

sins(X, [H|T], NL) :-    % Divide the List into Head and Tail.
    X =< H,              % Check if Element is less than or equal to Head.
    NL = [X, H|T];       % If so, add it into the List.
    sins(X, T, NL1),     % Else inspect Tail.
    X > H,               % If Element is greater than Head,
    NL = [H|NL1].        % Insert Head with new List from further iterations.
                         % Thus adding previously removed Heads.

% Insertion sort on List producing Sorted List.
isort([], []).    % Base case with empty List.
isort([E], [E]).  % Base case with one Element.

isort([H|T], SL) :-      % Divide List into Head and Tail.
    isort(T, SL1),
    sins(H, SL1, SL).    % sins/3 Insert Element in the proper place
                         % so that you retain a sorted List.

% Create List S and G from given List, so that:
%     - Elements in S are less than or equal to P
%     - Elements in G are greater than P
pivoting(_, [], [], []).    % Base case with empty List.

pivoting(P, [H|T], S, G) :-    % Divide the List into Head and Tail.
    pivoting(P, T, S1, G1),    % Further divide the Tail.
    (H =< P,                   % Check if Head is less than or equal to P.
    S = [H|S1],                % If so, add Head to S with further iterations S and
    G = G1;                    % set G to further iterations G.
    H > P,                     % Else if Head is greater than P.
    S = S1,                    % Set S to further iterations S and
    G = [H|G1]).               % add Head to G with further iterations G.

% Use Quick Sort for sorting out the List.
quick_sort([], []).    % Base case with empty List.

quick_sort([H|T], SL) :-        % Divide the List into Head and Tail.
    pivoting(H, T, S, G),       % Get Smaller and Greater Lists using Head as pivot.
    quick_sort(S, S1),          % Use quick sort on smaller List.
    quick_sort(G, G1),          % Use quick sort on greater List.
    conc(S1, [H|G1], SL).       % Combine smaller with Head and greater List into sorted one.
