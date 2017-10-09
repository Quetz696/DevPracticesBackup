%% @author Robert ten Bosch <roberttenbosch@gmail.com>[http://nu.nl]
%% @doc Functions calculating velocities of falling
%% objects in a vacuum.
%% @reference from <a href="http://google.com">some link </a>
%% @copyright 2017 Robert ten Bosch
%% @version 0.0.1

-module(drop).
-export([drop/0,  fall_velocity/2]).

drop() ->
  receive
    {From, SpaceObject, Distance} ->
      From ! {SpaceObject, Distance, fall_velocity(SpaceObject,Distance)},
      drop()
  end.


fall_velocity(SpaceObject, Distance) ->
  try
    Gravity = case SpaceObject of
      earth  -> 9.8;
      moon  -> 1.6;
      mars  -> 3.71
    end,
    math:sqrt(2 * Gravity * Distance)
  of
    Result -> Result
  catch
    error:Error -> {error, self(), Error}
  end.
