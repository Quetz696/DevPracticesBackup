-module (count).
-export([countdown/1, countup/1]).

countdown(0) ->
  io:format("Pop goes the weasel!~n");
countdown(From) when From > 0 ->
  Num = fac(From),
  io:format("~w! = ~w ~n",[From, Num]),
  countdown(From - 1).

fac(0) ->
  1;
fac(N) ->
  N * fac(N-1).

countup(Limit) ->
  countup(1, Limit).

countup(Count, Limit) when Count =< Limit ->
  io:format("~w!!1 on our way to --> ~w  ~n",[Count, Limit]),
  timer:sleep(Limit),
  countup(Count +1 , Limit);
countup(_Count, _Limit) ->
  io:format("Done!!").
