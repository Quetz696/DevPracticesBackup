-module(clock).
-export([stop/0,start/2]).


start(Time, Fun) ->
  register(clock, spawn(fun() -> tick(Time, Fun) end)).


stop() -> clock ! stop.

tick(Time, Fun) ->
  receive
    stop -> void
  after Time ->
    Fun(),
    tick(Time, Fun)
  end.
