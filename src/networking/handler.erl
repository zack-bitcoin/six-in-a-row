-module(handler).

-export([init/3, handle/2, terminate/3, doit/1]).
%example of talking to this handler:
%httpc:request(post, {"http://127.0.0.1:3010/", [], "application/octet-stream", "echo"}, [], []).
%curl -i -d '[-6,"test"]' http://localhost:3011
%curl -i -d echotxt http://localhost:3010

handle(Req, State) ->
    %{Length, Req2} = cowboy_req:body_length(Req),
    {ok, Data, Req3} = cowboy_req:body(Req),
    true = is_binary(Data),
    %io:fwrite("handler Data "),
    %io:fwrite(Data),
    %D2 = case X of
	%     91 -> jiffy:decode(Data);
	%     _ -> packer:unpack(Data)
	% end,
    %true = is_binary(Data), 
    %io:fwrite("handler error "),
    %io:fwrite(D2),
    A = packer:unpack(Data),
    B = doit(A),
    D = packer:pack(B),
    %Headers = [{<<"content-type">>, <<"application/octet-stream">>},
    Headers = [{<<"content-type">>, <<"application/octet-stream">>},%<<"text/html">>},
    {<<"Access-Control-Allow-Origin">>, <<"*">>}],
    {ok, Req4} = cowboy_req:reply(200, Headers, D, Req3),
    {ok, Req4, State}.
init(_Type, Req, _Opts) -> {ok, Req, no_state}.
terminate(_Reason, _Req, _State) -> ok.
-define(WORD, 10000000).%10 megabytes.
doit({board}) ->
    board:board();
doit({new_game, Size}) ->
    board:new_game(Size);
doit({undo}) ->
    board:undo();
doit({play, X, Y}) ->
    board:play(X, Y);
doit({move_number}) ->
    board:move_number();
doit(X) ->
    io:fwrite("I can't handle this \n"),
    io:fwrite(packer:pack(X)), %unlock2
    {error}.
 

    
