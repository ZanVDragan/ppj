% Shift elements in first list and store in second.
shiftleft([H|T], L) :-
    conc(T, [H], L).

% Shift first list for one to the right and store in second.
shiftright(L1, L2) :-
    conc(L, [H], L1), % Get the first element and first list without it.
    conc([H], L, L2). % Concatenate them.
% Using shiftleft.
%shiftright(L1, L2) :-
%    shiftleft(L2, L1).

% Store reverse first list in second.
rev([], []). % (end case)

rev([H|T], L2) :- % Split the first list.
    rev(T, TL), % Recirsive call until empty list.
    conc(TL, [H], L2). % Concatenate head to the given list.

% Check if list reads the same both ways.
palindrome(L) :-
    rev(L, L).

evenlen([]).

evenlen([_,_|T]) :-
    evenlen(T).

oddlen([_|T]) :-
    evenlen(T).

oddlen(L) :-
    not(evenlen(L)).

% Find length of given list.
len([], 0).

len([_|T], Len) :-
    len(T,X),
    Len is X + 1.

% Sum all the elements of given list.
sum([], 0).

sum([H|T], Sum) :- % Divide list into head and tail.
    sum(T, X), % Recursive call with tail as new list.
    Sum is X + H. % Add head to returned X.
