% 
% Safe cracking puzzle in ASP.
%
% From the Oz Primer:
% http://www.comp.nus.edu.sg/~henz/projects/puzzles/digits/index.html
% """
% The code of Professor Smart's safe is a sequence of 9 distinct 
% nonzero digits C1 .. C9 such that the following equations and
% inequations are satisfied:
%
%       C4 - C6   =   C7
%  C1 * C2 * C3   =   C8 + C9
%  C2 + C3 + C6   <   C8
%            C9   <   C8
%
%  and
%
%  C1 <> 1, C2 <> 2, ..., C9 <> 9
%
% can you find the correct combination?
% """
%
% Solution: 4, 3, 1, 8, 9, 2, 6, 7, 5
%

% This was created by Hakan Kjellerstrand, hakank@bonetmail.com
% See also http://www.hakank.org/answer_set_programming/
%

values(1..9).

% all different
1 { x(I, Val) : values(Val) } 1 :- values(I).
1 { x(I, Val) : values(I) } 1 :- values(Val).

% Commenting out C5 (which is not used) is much faster.
safe_cracking :-
  x(1,C1), x(2,C2),x(3,C3),x(4,C4), % x(5,C5),
  x(6,C6),x(7,C7),x(8,C8), x(9,C9),  
  C4 - C6 == C7,
  C1 * C2 * C3 == C8 + C9,
  C2 + C3 + C6 < C8,
  C9 < C8.

:- not safe_cracking.        

% no fix points
:- x(I,I), values(I).

#hide.
#show x(I, Val).
