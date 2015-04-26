-module(finder_tests).
-include_lib("eunit/include/eunit.hrl").

first_included_test() ->
  ?assertEqual([1, 5], finder:search([2, 3, 4, 6, 7])).

close_skipped_test() ->
  ?assertEqual([3, 4], finder:search([1, 2, 5, 6, 7])).

search_test() ->
  List = finder:init(),
  ?assertEqual(2, length(finder:search(List))).
