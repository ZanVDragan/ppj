% Return if X was found.
memberBT(X, b(_,X,_)).

% Recursive search if X is part of a given BinaryTree.
memberBT(X, b(Left, _, Right)):-
    memberBT(X, Left);    % Search left sub-tree.
    memberBT(X, Right).   % Search right sub-tree.

% b(L, E, R) ---> Element of a tree with Left and Right children.
% 'nil' represents an empty tree.
% Can be nested: b(b(nil,2,nil),1,b(nil,3,nil))
%       1
%   2       3
%nil nil nil nil

% If found nil element, return it.
mirrorBT(nil, nil).

% Create a mirror BinaryTree from given one.
%mirrorBT(b(Left, E, Right), NBT):-
%    mirrorBT(Left, L),    % Get left side of the tree.
%    mirrorBT(Right, R),   % Get right side of the tree.
%    NBT=b(R, E, L).       % Swap left and right.

mirrorBT(b(Left, E, Right), b(R, E, L)):-
    mirrorBT(Left, L),
    mirrorBT(Right, R).

% Stop at nil BinaryTree and return 0.
numberBT(nil, 0).

% Recursively count all BinaryTree nodes.
numberBT(b(Left, _, Right), N):-
    numberBT(Left, L),    % Count nodes in Left sub-tree.
    numberBT(Right, R),   % Count nodes in Right sub-tree.
    N is L + R + 1.       % Sum of Left, Right and current node.

% If at the end, return 0.
depthBT(nil, 0).

% Count depth of BinaryTree recursively.
depthBT(b(Left, _, Right), D):-
    depthBT(Left, L),        % Go through the Left sub-tree.
    depthBT(Right, R),       % Go through the Right sub-tree.
    (L >= R, D is L + 1;     % If Left Depth is greater or equal, store it and add 1.
    L < R, D is R + 1).      % If Right Depth is greater, store it and add 1.

% If nil, return empty List.
tolistBT(nil, []).

% Turn BinaryTree to List.
tolistBT(b(Left, E, Right), L):-
    tolistBT(Left, LL),    % Get Left sub-tree as List.
    tolistBT(Right, RL),   % Get Right sub-tree as List.
    conc(LL, [E|RL], L).   % Concatenate Left and Element with Right to List.

deleteBT(X, b(nil, X, nil), nil).    % Base case with X as leaf.

deleteBT(X, b(L, X, R), NT) :-    % Case where X is found.
    L = b(_, LE, _),              % Get Left Element.
    deleteBT(LE, L, NLT),         % Swap it with current and delete it recursively.
    NT = b(NLT, LE, R);           % Create new Tree with new Left subtree.
    R = b(_, RE, _),              % Get Right Element.
    deleteBT(RE, R, NRT),         % Swap it with current and delete it recursively.
    NT = b(L, RE, NRT).           % Create new Tree with new Right subtree.
                                  % With every swap, a subtree has to be fixed as well.
                                  % Thus additional delition of the chosen element.
    
deleteBT(X, b(L, E, R), NT) :-    % Case where X is not found.
    deleteBT(X, L, NLT),          % Search for it in the Left subtree.
    NT = b(NLT, E, R);            % Create new tree with new Left subtree.
    deleteBT(X, R, NRT),          % Search for it in the Right subtree.
    NT = b(L, E, NRT).            % Create new tree with new Right subtree.

% Insert Element anywhere in the Tree (find all solutions).
insertBT(X, T, NT) :-
    deleteBT(X, NT, T).    % deleteBT/3 Deletes X from NT creating T.
                           % Effectively you get all possible solutions of NT,
                           % such that deletion of X from NT would give T.
                           % (delete and insert are reversed operations)

% Return true if X is found.
memberT(X, T):-
    T =.. [t, X|_].

memberT(X, T):-
    T =.. [t, _|LT],    % Create a List with sub-trees.
    memb(Tree, LT),     % Go through all the members of the List.
    memberT(X, Tree).   % Check for given X in this Tree.
                        % Term =.. [Functor, Arg1, Arg2, ..., ArgN]

maxT(T, M) :-
    findall(X, memberT(X, T), L),    % Find all Elements of the Tree and store them in a List.
    max(L, M).                       % Find Maximum in given List.
