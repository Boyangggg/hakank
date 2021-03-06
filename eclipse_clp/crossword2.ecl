/*

  Cross word in ECLiPSe.
 
  This is a standard example for constraint logic programming. See e.g.
 
  http://www.cis.temple.edu/~ingargio/cis587/readings/constraints.html
  """
  We are to complete the puzzle
 
       1   2   3   4   5
     +---+---+---+---+---+       Given the list of words:
   1 | 1 |   | 2 |   | 3 |             AFT     LASER
     +---+---+---+---+---+             ALE     LEE
   2 | # | # |   | # |   |             EEL     LINE
     +---+---+---+---+---+             HEEL    SAILS
   3 | # | 4 |   | 5 |   |             HIKE    SHEET
     +---+---+---+---+---+             HOSES   STEER
   4 | 6 | # | 7 |   |   |             KEEL    TIE
     +---+---+---+---+---+             KNOT
   5 | 8 |   |   |   |   |
     +---+---+---+---+---+       
   6 |   | # | # |   | # |       The numbers 1,2,3,4,5,6,7,8 in the crossword
     +---+---+---+---+---+       puzzle correspond to the words 
                                                   that will start at those locations.
  """

  The model was inspired by Sebastian Brand's Array Constraint 
  cross word example but it is slightly generalized
  * http://www.cs.mu.oz.au/~sbrand/project/ac/
  * http://www.cs.mu.oz.au/~sbrand/project/ac/examples.pl

  Also, compare with the following models:
  * MiniZinc: http://www.hakank.org/minizinc/crossword.mzn
              http://www.hakank.org/minizinc/crossword2.mzn (more general version)
  * Choco: http://www.hakank.org/choco/CrossWord.java
  * JaCoP: http://www.hakank.org/JaCoP/CrossWord.java
  * Comet: http://www.hakank.org/comet/crossword.co
  * Gecode: http://www.hakank.org/gecode/crossword.cpp


  Model created by Hakan Kjellerstrand, hakank@bonetmail.com
  See also my ECLiPSe page: http://www.hakank.org/eclipse/

*/

:-lib(ic).
:-lib(ic_search).
:-lib(listut).

go :-

        overlapping(Overlappings),
        dim(Overlappings,[NumOverlappings,4]),
        words(Words),
        length(Words,NumWords),

        ESize = 8,
        length(E,ESize),
        E :: 1..NumWords,
        ic:alldifferent(E),

        ( for(I,1,NumOverlappings), param(Words,Overlappings,E) do

              % get this overlapping
              Overlapping is Overlappings[I],              
              O1 is Overlapping[1], % first word
              O2 is Overlapping[2], % position in first word
              O3 is Overlapping[3], % second word
              O4 is Overlapping[4], % position in second word
             
              % fetch the two E variables to use
              nth1(O1,E,E1),
              nth1(O3,E,E2), 
              
              % Get the words
              nth1(E1,Words,Word1),
              nth1(E2,Words,Word2),

              Word1 \= Word2,

              % The same char in the overlapping.
              nth1(O2,Word1,C),
              nth1(O4,Word2,C)

        ),
        
        term_variables([E], Vars),
        search(Vars,0,first_fail,indomain,complete, [backtrack(Backtracks)]),
        writeln("E":E),
        ( for(I,1,ESize), param(E,Words) do
              nth1(I,E,WordIndex),
              nth1(WordIndex,Words,Word),
              printf("%d (%d): ",[I,WordIndex]),
              print_word(Word),
              nl
        ),
        writeln(backtracks:Backtracks).



print_word(Word) :-
        ( foreach(W,Word) do 
              ground(W) 
        ->
              printf("%w", [W])
        ; 
              true
        ).


%
% Definition of the words. A _ is used to fill the row.
%
words([[h, o, s, e, s], %%  HOSES
       [l, a, s, e, r], %%  LASER
       [s, a, i, l, s], %%  SAILS
       [s, h, e, e, t], %%  SHEET
       [s, t, e, e, r], %%  STEER
       [h, e, e, l],    %%  HEEL
       [h, i, k, e],    %%  HIKE
       [k, e, e, l],    %%  KEEL
       [k, n, o, t],    %%  KNOT
       [l, i, n, e],    %%  LINE
       [a, f, t],       %%  AFT
       [a, l, e],       %%  ALE
       [e, e, l],       %%  EEL
       [l, e, e],       %%  LEE
       [t, i, e]]).     %%  TIE


%
% Overlappings of the words
% As an array for easy acces 
%
overlapping([]([](1, 3, 2, 1), 
               [](1, 5, 3, 1), 
             
               [](4, 2, 2, 3), 
               [](4, 3, 5, 1), 
               [](4, 4, 3, 3), 
               
               [](7, 1, 2, 4), 
               [](7, 2, 5, 2), 
               [](7, 3, 3, 4), 
               
               [](8, 1, 6, 2), 
               [](8, 3, 2, 5), 
               [](8, 4, 5, 3), 
               [](8, 5, 3, 5))).  
