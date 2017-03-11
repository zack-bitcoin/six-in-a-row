-module(board).
-behaviour(gen_server).
-export([start_link/0,code_change/3,handle_call/3,handle_cast/2,handle_info/2,init/1,terminate/2,
	 play/2, undo/0, new_game/0, new_game/1, board/0,
	 move_number/0,
	 test/0]).
-record(board, {moves = [], move_number = 1, state, size}).
-define(default_size, 19).
init(ok) -> {ok, empty_board(?default_size)}.
start_link() -> gen_server:start_link({local, ?MODULE}, ?MODULE, ok, []).
code_change(_OldVsn, State, _Extra) -> {ok, State}.
terminate(_, _) -> io:format("died!"), ok.
handle_info(_, X) -> {noreply, X}.
handle_cast({play, X, Y}, B) -> 
    S = B#board.size,
    true = X > 0,
    true = Y > 0,
    true = X =< S,
    true = Y =< S,
    M = B#board.move_number,
    C = color(M),
    NewBoard = play_color(C, B#board.state, X, Y),
    B2 = B#board{move_number = M + 1,
		 moves = [{X, Y}|B#board.moves],
		 state = NewBoard},
    {noreply, B2};
handle_cast({new_game, Size}, _) -> 
    {noreply, empty_board(Size)};
handle_cast(undo, B) -> 
    Moves = B#board.moves,
    {X, Y} = hd(Moves),
    NewBoard = play_color(empty, B#board.state, X, Y),
    N2 = B#board{move_number = B#board.move_number - 1, 
			moves = tl(Moves),
			state = NewBoard
		       },
    {noreply, N2};
handle_cast(_, X) -> {noreply, X}.
handle_call(_, _From, X) -> {reply, X, X}.

board() ->
    B = gen_server:call(?MODULE, board),
    to_lists(B#board.state).
to_lists(X) when is_atom(X) ->
    X;
to_lists([]) -> [];
to_lists([H|T]) -> 
    [to_lists(H)|
     to_lists(T)];
to_lists(X) when is_tuple(X) ->
    to_lists(tuple_to_list(X)).


move_number() ->
    B = gen_server:call(?MODULE, board),
    B#board.move_number.
    
new_game() -> new_game(?default_size).
new_game(Size) ->
    gen_server:cast(?MODULE, {new_game, Size}).
undo() ->
    gen_server:cast(?MODULE, undo).
    
play(X, Y) ->
    B = gen_server:call(?MODULE, board),
    S = B#board.state,
    A = element(Y, element(X, S)),
    A = empty,
    gen_server:cast(?MODULE, {play, X, Y}).

empty_board(Size) -> 
    B = empty_helper(Size),
    #board{size=Size, state=B}.
empty_helper(Size) ->
    Row = empty_helper3(Size),
    list_to_tuple(empty_helper2(Size, Row)).
empty_helper2(0, _) -> [];
empty_helper2(N, R) -> [R|empty_helper2(N-1, R)].
empty_helper3(S) ->
    list_to_tuple(empty_helper4(S)).
empty_helper4(0) -> [];
empty_helper4(N) -> [empty|empty_helper4(N-1)].

color(M) ->
    A = M  div 2,
    C = A rem 2,
    case C of
	0 -> black;
	1 -> white
    end.
play_color(C, S, X, Y) ->
    G = setelement(Y, element(X, S), C),
    setelement(X, S, G).

test() ->
    black = color(1),
    white = color(2),
    white = color(3),
    black = color(4),
    black = color(5),
    B = {{empty, empty, empty},
	 {empty, empty, empty},
	 {empty, empty, empty}},
    B2 = empty_board(3),
    B = B2#board.state,
    Color = black, 
    B4 = play_color(Color, B, 2, 2),
    B4 = {{empty, empty, empty},
	  {empty, Color, empty},
	  {empty, empty, empty}},
    %B4 = packer:unpack(packer:pack(B4)),
    success.

