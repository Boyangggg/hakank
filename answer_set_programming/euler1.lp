% 
% Project Euler, problem 1 ASP.
% 
% Problem 1
% """
% If we list all the natural numbers below 10 that are multiples of 3 or 5, 
% we get 3, 5, 6 and 9. The sum of these multiples is 23.
% Find the sum of all the multiples of 3 or 5 below 1000.
% """
%
% This was created by Hakan Kjellerstrand, hakank@bonetmail.com
% See also http://www.hakank.org/answer_set_programming/
%

#const n=1000.
number(1..n).

mod_test(N) :- number(N), N #mod 3 == 0.
mod_test(N) :- number(N), N #mod 5 == 0.

total(Sum) :- Sum = #sum [mod_test(N) : number(N) : N < n = N].

#hide.
#show total(Sum).
