-module (geometry1).
-export([area/1, test/0]).

area ({rectangle, Width, Height}) -> Width * Height;
area ({square, Side}) -> Side * Side.

test() ->
  144 = area({square, 12}),
  12 = area({rectangle, 3,4}),
  test_worked.
