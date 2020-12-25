-module(aoc2020_6_1).
-export([main/1]).

read_input(FileName) ->
  {ok, Data} = file:read_file(FileName),
  Content = unicode:characters_to_list(Data),
  string:split(Content, ["\n\n"], all).

prepare_input(Lines) ->
  lists:map(fun(L) -> lists:filter(fun(C) -> C /= 10 end, L) end, Lines).

count_distinct(Str) ->
  F = fun(C, Set) -> sets:add_element(C, Set) end,
  sets:size(lists:foldl(F, sets:new(), Str)).

solution(Data) -> 
  lists:foldl(fun(Str, Sum) -> Sum + count_distinct(Str) end, 0, Data).

main(_Args) ->
  io:format("abcd should be 4: ~w\n", [solution(["abcd"])]),
  io:format("a aa should be 2: ~w\n", [solution(["a", "aa"])]),
  io:format("example: ~w\n", [solution(prepare_input(read_input("example_input.txt")))]),
  io:format("example: ~w\n", [solution(prepare_input(read_input("input.txt")))]).
