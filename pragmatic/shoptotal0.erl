-module (shoptotal0).
-export ([total/1]).
-import(mylist, [map/2, sum/1]).


total(L) ->sum(map(fun({What, N})-> shop:cost(What) * N end, L)).
