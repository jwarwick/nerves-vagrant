-module(nerves_sample_server).
-behaviour(gen_server).

-export([start_link/0, get_value/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

start_link() ->
      gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
      {ok, 0}.

get_value() ->
      gen_server:call(?MODULE, get_value).

%% callbacks
handle_call(get_value, _From, State) ->
  io:format("Hello from server!~n", []),
  {reply, {ok, State}, State + 1};

handle_call(_Request, _From, State) ->
  Reply = ok,
  {reply, Reply, State}.

handle_cast(_Msg, State) ->
  {noreply, State}.

handle_info(_Info, State) ->
  {noreply, State}.

terminate(_Reason, _State) ->
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

