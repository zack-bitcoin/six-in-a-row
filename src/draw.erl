-module(draw).
-export([doit/0]).
-define(L, "src/web/").

doit() ->
    B = board:board(),
    B2 = listify(B),
    doit2(B2, 1),
    doit_board(length(B2)).
doit2([], _) -> ok;
doit2([Row|T], N) ->
    CMD = "convert " ++ row_to_string(Row) ++ " +append " ++ ?L ++ "row" ++ integer_to_list(N) ++ ".png",
    os:cmd(CMD),
    doit2(T, N+1).
row_to_string([]) -> "";
row_to_string([X|T]) ->
    Y = case X of
	    empty -> "empty.png ";
	    black -> "black.png ";
	    white -> "white.png "
	end,
    ?L ++ Y ++ row_to_string(T).

doit_board(Size) ->
    CMD = "convert " ++ many_rows_to_string(Size) ++ " -append " ++ ?L ++ "board.png",
    os:cmd(CMD).
many_rows_to_string(0) -> "";
many_rows_to_string(Size) ->
    many_rows_to_string(Size - 1) ++ " " ++ ?L++ "row" ++ integer_to_list(Size) ++ ".png".
    
     

listify(B) when is_atom(B) -> B;
listify([]) -> [];
listify([X|T]) ->
    [listify(X)|listify(T)];
listify(B) when is_tuple(B) ->
    B2 = tuple_to_list(B),
    listify(B2).
    
