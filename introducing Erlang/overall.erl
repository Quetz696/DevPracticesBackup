-module (overall).
-export([product/1]).

product([]) -> 0;
product([Head | Tail]) ->
  case Tail of
    [] -> Head;
    _  ->Head * product(Tail)
  end.
