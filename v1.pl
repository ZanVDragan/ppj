% Check if X is mother of Y.
mother(X, Y) :-
    female(X),
    parent(X,Y).

% Check if X is father of Y.

father(X,Y) :-
    male(X),
    parent(X,Y).

% Check if X is grandparent of Y.

grandparent(X,Y) :-
    parent(Z,Y),
    parent(X,Z).

% Check if X is sister of Y.

sister(X,Y) :-
    female(X),
    parent(Z,X),
    parent(Z,Y),
    X \== Y.

% Check if X is brother of Y.

brother(X,Y) :-
    male(X),
    parent(Z,X),
    parent(Z,Y),
    X \== Y.

% Check if X is aunt of Y.

aunt(X,Y) :-
    parent(Z,Y),
    sister(X,Z).

% Check if X is cousin of Y.

cousin(X,Y) :-
    grandparent(Z,X),
    grandparent(Z,Y),
    not(brother(X,Y)),
    not(sister(X,Y)),
    X \== Y.

% Check if X is ancestor of Y.

ancestor(X,Y) :-	% End condition (base case).
    parent(X,Y).

ancestor(X,Y) :-	% Recursive search.
    parent(Z,Y),
    ancestor(X,Z).

% Check if X is descendant of Y.

descendant(X,Y) :-
    ancestor(Y,X).
