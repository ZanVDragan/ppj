% Construct a string of 'ab' where a can repeat m-times and b n-times (m & n >= 0).
% Valid strings: [], a, aab, abbb, bbb, ...
% Generate with: conc(Word,_,_), ab(Word,[]).
% ab to empty or a, b
ab --> [] | a, b.
% a to empty or a
a  --> [] | [a], a.
% b to empty or b
b  --> [] | [b], b.

% Construct a string '+-+', where + repeats n >= 0 times and m > 0 times.
% Valid strings: -, ++-++, +--+, ...
% Generate wiht: conc(Word,_,_), flower(Word,[]).
% Can be just minus or + string +.
flower --> m | [+], flower, [+].
% One or multiple -.
m      --> [-] | [-], m.

% Return any digit from 0 to 9.
% Call: digit(D, []).
% digit-->0;1;2;3;4;5;6;7;8;9. (possible solution)
% digit-->0|1|2|3|4|5|6|7|8|9. (possible solution)
digit -->[X], {member(X, [0,1,2,3,4,5,6,7,8,9])}.

% Generate a number which can have leading 0s.
% Call: number(N, []).
% One digit or digit and continuation.
number-->digit | digit, number.

% Construct a number that does not have leading 0s.
% Call: number_proper(NP, []).
no_zero       --> [1]|[2]|[3]|[4]|[5]|[6]|[7]|[8]|[9].
% Any digit or non-zero number with continuation or non-zero number with any digit and continuation.
number_proper --> digit | no_zero, number_proper | no_zero, digit, number_proper.

% Construct a number from given argument List.
% Example call: number(N, [1, 2, 3, 4], []).
% Retrieve a digit from 0 to 9.
nums(D)   --> [D], {member(D, [0,1,2,3,4,5,6,7,8,9])}.
% Single digit number or larger number with single digit, where each step is multiplied by 10.
number(N) --> nums(N) | number(M), nums(D), {N is M * 10 + D}.

% Construct nested parenthesis.
% Valid strings: (), (()), ()(()), (()())(), ...
% Invalid strings: )(, (((), )), ...
% Call: paren(P, []).
% Can be nothing.
paren --> [].
% Can be left and some combination and right and some combination.
paren --> ['('], paren, [')'], paren.

% Retrieve the largest depth of nested parenthesis.
% Example call: paren(D, ['(','(',')',')','(',')'], []).
% For empty string return 0.
paren(D) --> [], {D is 0}.
% Build left and continuation od depth D1 and right and continuation of depth D2.
% Check if D1 is greater than or equal to D2. Add plus one for currently added parenthesis and assign D1 to D.
% Else assign D2 to D.
paren(D) --> ['('], paren(D1), [')'], paren(D2),
             {D1 >= D2, D is D1 + 1; D1 < D2, D is D2}.
