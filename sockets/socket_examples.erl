-module(socket_examples).
-compile(export_all).

nano_get_url() ->
  nano_get_url("www.google.com").

nano_get_url(Host) ->
  {ok, Socket} = gen_tcp:connect(Host, 80, [binary, {packet,0}]),
  ok =  gen_tcp:send(Socket, "GET / HTTP/1.0\r\n\r\n"),
  reveice_data(Socket, []).


reveice_data(Socket, SoFar) ->
  receive
    {tcp, Socket, Bin} ->
      reveice_data(Socket, [Bin|SoFar]);
    {tcp_closed, Socket} ->
      list_to_binary(lists:reverse(SoFar))
  end.



start_nano_server() ->
  {ok, Listen} = gen_tcp:listen(2345,[binary, {packet,4},
                                      {reuseaddr, true},
                                      {active, true}]),
  {ok, Socket} = gen_tcp:accept(Listen),
  gen_tcp:close(Listen),
  loop(Socket).


start_seq_server() ->
  {ok, Listen} = gen_tcp:listen(2345,[binary, {packet,4},
                                      {reuseaddr, true},
                                      {active, true}]),
  seq_loop(Listen).

seq_loop(Listen) ->
  {ok, Socket} = gen_tcp:accept(Listen),
  loop(Socket),
  seq_loop(Listen).


start_parallel_server() ->
  {ok, Listen} = gen_tcp:listen(2345,[binary, {packet,4},
                                    {reuseaddr, true},
                                    {active, true}]),
  spawn(fun() -> par_connect(Listen) end).

par_connect(Listen) ->
  {ok, Socket} = gen_tcp:accept(Listen),
  spawn(fun() -> par_connect(Listen) end),
  loop(Socket).

loop(Socket) ->
  receive
  {tcp, Socket, Bin} ->
    io:format("Server reveived binary = ~p~n",[Bin]),
    Str = binary_to_term(Bin),
    io:format("Server (unpacked) ~p~n",[Str]),
    Reply = string2value(Str),
    io:format("Server Replying  ~p~n",[Reply]),
    gen_tcp:send(Socket, term_to_binary(Reply)),
    loop(Socket);
  {tcp_closed, Socket} ->
    io:format("Server Socket closed Replying  ~p~n",[Socket])
  end.

nano_client_eval(Str) ->
  {ok, Socket} = gen_tcp:connect("localhost",2345,
                                [binary, {packet, 4}]),
  ok = gen_tcp:send(Socket, term_to_binary(Str)),
  receive
    {tcp, Socket, Bin} ->
      io:format("Client received binary = ~p~n",[Bin]),
      Val = binary_to_term(Bin),
      io:format("Client result = ~p~n",[Val]),
      gen_tcp:close(Socket)
  end.




string2value(Str) ->
  {ok, Tokens, _} = erl_scan:string(Str ++ "."),
  {ok, Exprs} = erl_parse:parse_exprs(Tokens),
  Bindings = erl_eval:new_bindings(),
  {value, Value, _} = erl_eval:exprs(Exprs, Bindings),
  Value.
