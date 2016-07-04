% Shift elements in first list and store in second.
shiftleft([H|T], L) :-    % Divide on Head and Tail.
    conc(T, [H], L).      % Concatenate Head at the end of Tail.

% Shift first list for one to the right and store in second.
shiftright(L1, L2) :-
    conc(L, [H], L1), % Get last Element of given List.
    conc([H], L, L2). % Concatenate Element at the front of the List.
% Using shiftleft.
%shiftright(L1, L2) :-
%    shiftleft(L2, L1).

% Store reverse first list in second.
rev([], []). % Empty List. (base case)

rev([H|T], L2) :- % Split the on Head and Tail.
    rev(T, TL), % Recursive call with Tail.
    conc(TL, [H], L2). % Concatenate Head at the end of new Tail.

% Check if list reads the same both ways.
palindrome(L) :-
    rev(L, L). % Use reverse List method.
               % rev/2 makes L2 as reversed L1.

evenlen([]).    % Base case with empty List.

% Recursively check for event number of Elements.
evenlen([_,_|T]) :-    % Divide onto two Elements and Tail.
    evenlen(T).        % Proceed with Tail.

% Recursively check for odd number of Elements.
oddlen([_|T]) :-        % Divide onto one Element and Tail.
    evenlen(T).         % Proceed with Tail being even length.
                        % If Tail is even length after removing Head,
                        % then original List had to be of odd length.

oddlen(L) :-
    not(evenlen(L)).    % Check if its odd by negating even.

% Find length of given list.
len([], 0).    % Base case of empty List returns 0.

% Recursively divide List.
len([_|T], Len) :-
    len(T,X),        % Proceed with Tail.
    Len is X + 1.    % Add 1 in each iteration.

% Sum all the elements of given list.
sum([], 0).    % Base case with empty List returns 0.

sum([H|T], Sum) :- % Divide list into Head and Tail.
    sum(T, X), % Recursive call with Tail as new List.
    Sum is X + H. % Add Head to returned X.

% Determine minimum element in the List.
min([E], E).    % Base case with one Element.

min([H|T], Min) :-            % Divide the List into Head and Tail.
    min(T, MinT),             % Recursively check the Tail.
    (H < MinT, Min = H;       % If Head is less than temporary Min, assign Head as Min.
    H >= MinT, Min = MinT).   % Else if Head is greater than or equal as temporary Min, assign latter as Min.

% Base case with one element.
max([E], E).

% Recursive search for Maximum in a List.
% Divide a List into Head and Tail.
max([H|T], M) :-
    max(T, MT),        % Recursive call with Tail. Get Temporaray Maximum.
    (MT < H, M = H;    % If Head is greater then Temp Max, store Head as Max.
    MT >= H, M = MT).  % If Temp Max is greater or equal as Head, store Temp Max as Max.

% Check if given Sublist is a sublist of List.
sublist(L, SL) :-
    conc(_, T, L),    % Divide List into something and Tail.
    conc(SL, _, T).   % Divide Tail into Sublist and something.
                      % Effectively you get something Sublist something.
                      % Since Tail is a variable it is not defined, whilst
                      % Sublist is. So conc(_,SL,L), conc(SL,_,L) would
                      % define List as something and Sublist AND
                      % Sublist and something, respectively. Such a List
                      % would exist only as an empty List.
