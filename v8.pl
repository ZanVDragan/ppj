% Convert between SI and IEC digital storage standards.
% SI: 1MB (megabyte) = 10^6 byte
% IEC: 1MiB (mebibyte) = 2^20 byte
megabytes(SI, IEC) :-
    {SI * 10^6 = IEC * 2^20}.    % Using CLP(R) = Constraint Logic Programming (in Real numbers).

% Maximize Expression so that X and Y fall inside given constraints.
linear_opt(X, Y, MaxE) :-
    {
        0 =< X, X =< 5,
        Y >= 0,
        X + Y =< 7,
        X + 2*Y >= 4,
        Y =< X + 5,
        MaxE = -0.4*X + 3.2*Y
    },
    maximize(MaxE).

% Find maximal sum of two adjacent Elements in the List.
max_adj_pair(L, Max) :-
    conc(_, [H1, H2|_], L),    % Retrieve any two adjacent Elements.
    {Max = H1 + H2},           % Set sum as a constraint.
    maximize(Max).             % Maximize the constraint.

turkey(Brand1, Brand2, Cost):-
	{
	    A = Brand1*5 + Brand2*10,              % Ingridient A in food.
	    B = Brand1*4 + Brand2*3,               % Ingridient B in food.
	    C = Brand1*0.5,                        % Ingredient C in food.
	    A >= 90, B >= 48, C >= 1.5,            % Monthly dosage for each ingredient.
        Cost = Brand1*0.20 + Brand2*0.30       % Cost for: Brand1 is 0.2€/kg, Brand2 is 0.3€/kg.
    },
	minimize(Cost).                            % Minimize monthly expenses.

bounding_box([], X1/Y1, X2/Y2) :-        % Base case with empty List.
    minimize(X2 - X1),                   % Minimize rectangles sides.
    minimize(Y2 - Y1).

bounding_box([X/Y|L], X1/Y1, X2/Y2) :-   % Divide the List retrieving coordinates.
    {
        X1 =< X, X =< X2,                % Put on constraints so that points are
        Y1 =< Y, Y =< Y2                 % within the rectangle.
    },
    bounding_box(L, X1/Y1, X2/Y2).       % Recursively set constraints on all points.

% X/Y is a point in the List that is at most R away from all other points.
check([], _, _).    % Base case with empty List.

check([X/Y|T], R, Xc/Yc) :-    % Retrieve current point.
    {
        (X-Xc)*(X-Xc) + (Y-Yc)*(Y-Yc) =< R*R    % Put on constraint.
    },
    check(T, R, Xc/Yc).        % Recursively check the Tail.

center(L, R, Xc/Yc) :-
    memb(Xc/Yc, L),        % Retrieve all points.
    check(L, R, Xc/Yc).    % Check constraint.
