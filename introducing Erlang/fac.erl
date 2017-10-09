-module (fac).
-export([fac/1]).


fac(0) ->  1;
fac(Num) -> Num * fac(Num - 1).
