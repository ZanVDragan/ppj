% Insert X in L1 so it forms L2.
insert(X, L1, L2) :-
    L2 = [X|L1].
% Shorter:
% insert(X, L1, [X|L1]).

% Recursive walk through the list.
insert(X, L1, L2) :-
    L1=[H|T],            % Divide the first List on Head and Tail.
    insert(X, T, TX),    % Recursively go through Tail, creating new Tail (List).
    L2=[H|TX].           % Combine Head with new Tail into second List.
% Shorter:
% insert(X, [H|T], [H|L]) :-
%    insert(X, T, L).

% Check if E is part of L.
% Base case with single Element in the List.
memb(E, L) :-
    L=[H|_],    % _ <--- suppressing warning "Singleton variables: ..." = used once warning
                % '_' means anything
    E=H.        % Check if Head is in fact desired Element.
% Shorter:
% memb(E, [E|_]).

% Iterate over the list L.
memb(E, L) :-
    L=[_|T],
    memb(E, T).
% Shorter:
% memb(E, [_|T]) :-
%    memb(E, T).

% Get coins that sum up to 30:
% memb(C1, [1,2,5,10,20,50,100,200]), memb(C2, [1,2,5,10,20,50,100,200]), memb(C3, [1,2,5,10,20,50,100,200]), C1+C2+C3=:=30.

% Delete X from L1 and store new list in L2.
del(X, L1, L2) :-
    L1=[H|T],
    X=H,
    L2=T.
% Shorter:
% del(H, [H|T], T).

% Recursively find all deletion options.
del(X, L1, L2) :-
    L1=[H|T],
    del(X, T, TX),
    L2=[H|TX].
% Shorter:
% del(X, [H|T], [H|TX]) :-
%    del(X, T, TX).

% Duplicate each element in L1 and store in L2.
dup([], []). % Check if empty lists (base case).

dup(L1, L2) :-
    L1=[H|T],
    dup(T,L),
    L2=[H,H|L].
% Shorter:
% dup([H|T], [H,H|L]) :-
%    dup(T,L).

% Concatenate second list at the end of first and store in third.
conc([], L, L). % (base case)

conc(L1, L2, L) :-
    % Get Head and Tail.
    L1 = [H|T],
    % Add Head to TL2.
    L=[H|TL2],  % Ce na koncu, se ujame v neskoncno zanko pri klicu conc(X,Y,[1,2,3]).
                % H, T, TL2, L2 so same spremenljivke.
    % Concatenate recursively Tail and L2.
    conc(T, L2, TL2).

% Shorter:
%conc([H|T], L2, [H|TL2]) :-
%    conc(T, L2, TL2).

% memb with conc:
% memb(X, L) :-
%    conc(_, [X|_], L). % Checks whether X is the Head of the list.

% Find the last element of given list.
last_elem([E], E). % Return single Element. (base case)

last_elem([_|T], E) :- % Divide the list to anything and tail.
    last_elem(T, E). % Recursive call with tail as new list.

% Base case with empty list (even number of elements).
divide([],[],[]).
% Base case with one element (odd number of elements).
divide([H],[H],[]).
% Recursively store
%     - odd positioned elements in L1.
%     - even positioned elements in L2.
divide(L, L1, L2) :-
    L = [H1|T],            % Divide List on Head1 and Tail.
    T = [H2|TL],           % Further divide Tail on Head2 and TailL.
    divide(TL, T1, T2),    % Recursive call with current TailL.
    L1 = [H1|T1],          % Combine Head1 with Tail1 from next iteration.
    L2 = [H2|T2].          % Combine Head2 with Tail2 from next iteration.

% Base case with empty list.
permute([], []).

% Recursively permute element in the given List.
%permute([H|T], L) :-    % Divide List on Head and Tail.
%    permute(T, L1),     % Permute with Tail and temporary List.
%    insert(H, L1, L).   % Insert Head in temporary List and store as new List.
                         % insert/3 finds all possible insertions for Element in List.
permute(L, [H|T]) :-
    del(H, L, L1),
    permute(L1, T).
