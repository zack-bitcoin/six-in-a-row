-module(testnet_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    ssl:start(),
    application:start(inets),
    testnet_sup:start_link().


stop(_State) ->
    ok.

    
