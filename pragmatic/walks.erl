-module (walks).
% -export([plan_route/2]).
%
%
% -spec plan_route(From::piont(), To::piont()) -> route().
% -type direction() :: north | south | east | west.
% -type piont() :: {integer(), integer()}.
% -type route() :: [{go, direction(), integer()}].
% -type angle() :: {Degrees::0..360, Minutes::0..60, Seconds::0..60}.
% -type position() :: {latitude | longitude, angle()}.
% -spec plan_route2(From::position(), To::postition()) -> route().
%
%
% plan_route({X1, Y1}, {X2, Y2}) ->
%   [].
