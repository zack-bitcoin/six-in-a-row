-module(serve).
-export([start/1, pw/0, pw/1]).
start(Port) ->
    io:fwrite("start server\n"),
    D = [
	 {'_', [
		{"/:file", external_handler, []},
		{"/", handler, []}
	       ]}
	],
    Dispatch = cowboy_router:compile(D),
    K = [
	 {env, [{dispatch, Dispatch}]}
	],
    {ok, _} = cowboy:start_http(http, 100, [{ip, {0,0,0,0}},{port, Port}], K).

pw() ->  start(port:check()).
pw(X) ->
    port:change(X),
    pw().

