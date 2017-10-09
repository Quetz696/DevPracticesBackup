-module (ask).
-export([term/0]).

term() ->
  Input  = io:read("What input you give? >> "),
  process_term(Input).

process_term({ok, Term}) when is_tuple(Term) ->
  Velocity =  drop:fall_velocity(Term),
  io:format("Yields ~w. ~n", [Velocity]),
  term();
process_term({ok, quit}) ->
  io:format("ok i'll quit. you asshole!~n");
process_term({ok, _}) ->
  io:format("You idiot why did you not enter a fucking tuple. ~n"),
  timer:sleep(350),
  io:format("not feeling so smart now. Are we???~n"),
  timer:sleep(1500),
  io:format("Retard! ~n"),
  term();
process_term({error, Error}) ->
  io:format("Great now you caused an error! ~w ~n",[Error]),
  io:format("Why did you not enter a fucking tuple. ~n"),
  timer:sleep(350),
  io:format("not feeling so smart now. Are we???~n"),
  timer:sleep(500),
  io:format("Retard! ~n"),
  term().
