-module(finder).

-export([init/0, search/1]).

init() ->
  List = lists:seq(1, 1000000),
  List2 = lists:delete(random:uniform(1000000), List),
  lists:delete(random:uniform(1000000), List2).

search(List) ->
  First = lists:nth(1, List),
  case First > 1 of
    true -> search(List, [], [1]);
    false -> search(List, [], [])
  end.

search([], [], Acc) ->
  Acc;
search([], Rest, Acc) ->
  search(Rest, [], Acc);
search(List, Rest, Acc) ->
  Length = length(List),
  Middle = Length div 2,
  Item = lists:nth(Middle, List),
  NextItem = lists:nth(Middle + 1, List),
  ExpectedValue = lists:nth(1, List) + Middle - 1,
  
  case Length of
    2 -> [First | Tail] = List,
         Last = lists:last(List),
         search([], Rest, lists:merge(lists:sublist(lists:seq(First, Last),
                                              2,  Last - First - 1),
                                Acc));
    _ ->
      case NextItem - Item > 1 of
        true -> search([], get_rest(lists:sublist(List, Middle + 1, Length), Rest),
                       lists:merge(lists:sublist(lists:seq(Item, NextItem),
                                                 2,  NextItem - Item - 1),
                                   Acc));
        false ->
          case Item > ExpectedValue of
            true -> search(lists:sublist(List, Length - Middle),
                           get_rest(lists:sublist(List, Middle + 1, Length), Rest),
                           Acc);
            false -> search(lists:nthtail(Middle, List),
                            get_rest(lists:sublist(List, Length - Middle), Rest),
                            Acc)
          end
      end
  end.

get_rest(List, Rest) ->
  [First | Tail] = List,
  Last = lists:last(List),
  Length = length(List),
  case (First + Length) == Last of
    true -> List;
    false -> Rest
  end.
