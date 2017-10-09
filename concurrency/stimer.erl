-module (stimer).
-export([start/2, cancel/1]).

start(Time, Fun) -> spawn(fun() -> timer(Time, Fun) end).

cancel(Pid) -> Pid ! canceled.

timer(Time, Fun) ->
  receive
    canceled -> void
  after Time ->
    Fun()
  end.
