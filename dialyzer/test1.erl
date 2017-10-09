-module (test1).
-export([f1/0]).

f1() ->
  X = erlang:time(),
  seconds(X).

seconds({ Hour, Min, Sec}) ->
  (Hour * 60 + Min) * 60 + Sec.
% this wil give error erlang:time returns a three tuple
% seconds({_Year, _Month, _Day, Hour, Min, Sec}) ->
%   (Hour * 60 + Min) * 60 + Sec.
