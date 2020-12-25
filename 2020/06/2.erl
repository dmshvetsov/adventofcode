-module(aoc2020_6_2).
-export([main/1]).

read_input(FileName) ->
  {ok, Data} = file:read_file(FileName),
  Content = unicode:characters_to_list(Data),
  string:split(Content, ["\n\n"], all).

prepare_input(Lines) ->
  lists:map(fun(L) -> string:split(string:trim(L), "\n", all) end, Lines).

count_occurences([]) -> [];
count_occurences(Str) ->
  [H|T] = lists:sort(Str),
  count_occurences(T, H, 1).

count_occurences([H|T], H, Count) -> count_occurences(T, H, Count+1);
count_occurences([H|T], C, Count) -> [{Count, C}|count_occurences(T, H, 1)];
count_occurences([], C, Count) -> [{Count, C}].

count_unanimously(Group) ->
  F = fun({Count, _C}) -> Count == length(Group) end,
  length(lists:filter(F, count_occurences(lists:flatten(Group)))).

solution(Data) -> 
  lists:foldl(fun(Group, Sum) -> Sum + count_unanimously(Group) end, 0, Data).

main(_Args) ->
  io:format("example: ~w\n", [solution(prepare_input(read_input("example_input.txt")))]),
   io:format("solution: ~w\n", [solution(prepare_input(read_input("input.txt")))]).
