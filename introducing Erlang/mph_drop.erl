-module (mph_drop).
-export([mph_drop/0]).

mph_drop() ->
  process_flag(trap_exit, true),
  Drop = spawn_link(drop, drop,[]),
  convert(Drop).


convert(Drop) ->
  receive
    {SpaceObject, Distance} ->
      Drop ! {self(), SpaceObject, Distance},
      convert(Drop);
    {'EXIT', Pid,Reason} ->
      io:format("HUGE Failure; ~p died because of ~p~n",[Pid, Reason]),
      NewDrop = spawn_link(drop,drop, []),
      convert(NewDrop);
    {Space, Distance, {error, Pid, Reason}} ->
      error_logger:error_msg("Error from Pid = ~p with Reason = ~p~nWith Space = ~p and Distance =~p~n",
      [Pid, Reason, Space, Distance]),
      convert(Drop);
    {SpaceObject, Distance, Velocity} ->
      error_logger:info_msg("Velocity = ~p~n",[Velocity]),
      MhpVelocity = 2.23693629 * Velocity,
      io:format("On ~p a fall of ~p meters yields a velocity of ~p mph.~n",
      [SpaceObject, Distance,MhpVelocity]),
      convert(Drop)
  end.
