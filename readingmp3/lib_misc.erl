-module(lib_misc).
-export([dump/0, unconsult/2,unconsult2/2, dump/2]).



unconsult(File, L) ->
  {ok, S} = file:open(File, write),
  lists:foreach(fun(X) -> io:format(S, "~p.~n", [X]) end, L),
  file:close(S).


dump() -> 1.

unconsult2(File, L) ->
  {ok, S} = file:open(File, write),
  lists:foreach(fun(X) -> io:format(S, "~p.~n",[X]) end, L),
  file:close(S).

dump(File, Term) ->
    Out = File ++ ".tmp",
    io:format("** dumping to ~s~n",[Out]),
    {ok, S} = file:open(Out, [write]),
    io:format(S, "~p.~n",[Term]),
    file:close(S).
