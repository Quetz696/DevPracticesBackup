-module (mylist).
-export([sum/1, product/1, map/2]).

sum([H|T]) -> H + sum(T);
sum([]) -> 0.

product([H|T]) -> H * product([T]);
product([]) -> 1.

map( _ , []) -> [];
map(F, [H|T]) -> [F(H)| map(F, T)].
