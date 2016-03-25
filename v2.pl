% Insert X in L1 so it forms L2.
insert(X, L1, L2) :-
    L2 = [X|L1].
% Shorter:
% insert(X, L1, [X|L1]).

% Recursive walk through the list.
insert(X, L1, L2) :-
    L1=[H|T],
    insert(X, T, TX),
    L2=[H|TX].
% Shorter:
% insert(X, [H|T], [H|L]) :-
%    insert(X, T, L).

% Check if E is part of L.
% If E is provided as variable (X), it prints it out.
memb(E, L) :-
    L=[H|_],    % _ <--- suppressing warning "Singleton variables: ..." = used once warning
    E=H.

% Iterate over the list L.
memb(E, L) :-
    L=[_|T],
    memb(E, T).


% Get coins that sum up to 30:
% memb(C1, [1,2,5,10,20,50,100,200]), memb(C2, [1,2,5,10,20,50,100,200]), memb(C3, [1,2,5,10,20,50,100,200]), C1+C2+C3=:=30.ž

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
dup([], []). % Check if empty lists (end case).

dup(L1, L2) :-
    L1=[H|T],
    dup(T,L),
    L2=[H,H|L].
% Shorter:
% dup([H|T], [H,H|L]) :-
%    dup(T,L).

% Concatenate second list at the end of first and store in third.
conc([], L, L). % (end case)

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
last_elem([E], E). % (end case)

last_elem([_|T], E) :- % Divide the list to anything and tail.
    last_elem(T, E). % Recursive call with tail as new list.
