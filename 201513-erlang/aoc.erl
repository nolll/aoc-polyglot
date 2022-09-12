-module(aoc).
-export([run/0]).

readlines(FileName) ->
    {ok, Binary} = file:read_file(FileName),
    string:tokens(erlang:binary_to_list(Binary), "\n").

parseValue(StringValue) ->
    {IntValue, _} = string:to_integer(StringValue),
    IntValue.

parseAction(StringAction) ->
    IsGain = string:equal(StringAction, "gain"),
    if
        IsGain ->
            gain;
        true ->
            lose
    end.

getMultiplier(gain) ->
    1;
getMultiplier(lose) ->
    -1.

createGuest(Name, Rules) ->
    #{
        name => Name,
        rules => Rules
    }.

createRule(Name, Happiness) ->
    #{
        name => Name,
        happiness => Happiness
    }.

getGuest(Name, Guests) ->
    Exists = maps:is_key(Name, Guests),
    if
        Exists -> maps:get(Name, Guests);
        true -> createGuest(Name, [])
    end.

permutations([]) -> [[]];
permutations(L) -> [[H | T] || H <- L, T <- permutations(L -- [H])].

parseGuest(Row, Guests) ->
    S1 = string:trim(Row),
    S2 = string:trim(S1, trailing, "."),
    Parts = re:split(S2, " "),
    [Name, _, StringAction, StringValue, _, _, _, _, _, _, OtherName | _] = Parts,

    Action = parseAction(StringAction),
    Multiplier = getMultiplier(Action),
    Happiness = parseValue(StringValue) * Multiplier,

    Guest = getGuest(Name, Guests),
    Rules = maps:get(rules, Guest),
    Rule = createRule(OtherName, Happiness),
    createGuest(Name, lists:append(Rules, [Rule])).

getNextIndex(Index, NameList) ->
    Length = length(NameList),
    NextIndex = Index + 1,
    if
        NextIndex > Length -> 1;
        true -> NextIndex
    end.

getPrevIndex(Index, NameList) ->
    Length = length(NameList),
    PrevIndex = Index - 1,
    if
        PrevIndex < 1 -> Length;
        true -> PrevIndex
    end.

calculateHappinessForOneGuest(Index, Guest, NameList) ->
    PrevIndex = getPrevIndex(Index, NameList),
    NextIndex = getNextIndex(Index, NameList),
    PrevName = lists:nth(PrevIndex, NameList),
    NextName = lists:nth(NextIndex, NameList),
    AllRules = maps:get(rules, Guest),
    FilteredRules = lists:filter(
        fun(X) ->
            Name = maps:get(name, X),
            IsEqualToPrevName = string:equal(Name, PrevName),
            IsEqualToNextName = string:equal(Name, NextName),
            if
                IsEqualToPrevName ->
                    true;
                IsEqualToNextName ->
                    true;
                true ->
                    false
            end
        end,
        AllRules
    ),
    HappinessList = lists:map(
        fun(X) ->
            maps:get(happiness, X)
        end,
        FilteredRules
    ),
    lists:sum(HappinessList).

calculateHappinessForOneList(NameList, Guests) ->
    NameListWithIndexes = lists:enumerate(1, NameList),
    HappinessList = lists:map(
        fun({Index, X}) ->
            Guest = maps:get(X, Guests),
            calculateHappinessForOneGuest(Index, Guest, NameList)
        end,
        NameListWithIndexes
    ),
    lists:sum(HappinessList).

calculateHappiness(NameLists, Guests) ->
    lists:map(
        fun(X) ->
            calculateHappinessForOneList(X, Guests)
        end,
        NameLists
    ).

run() ->
    % Index = 2,
    % List = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
    % PrevIndex = getPrevIndex(Index, List),
    % NextIndex = getNextIndex(Index, List),
    % io:fwrite("indexes: ~w ~w ~w~n", [PrevIndex, Index, NextIndex]).

    Rows = readlines("input.txt"),
    Guests = parseGuests(Rows, false),
    Names = maps:keys(Guests),
    NameLists = permutations(Names),
    Happiness = calculateHappiness(NameLists, Guests),
    MaxHappiness = lists:max(Happiness),
    io:fwrite("happiness: ~w~n", [MaxHappiness]).
% Length = length(Names),

% io:fwrite("guest count: ~w~n", [Length]).

parseGuests(Rows, IncludeMe) ->
    InitialGuests = createGuestMap(IncludeMe),
    parseNextGuest(Rows, InitialGuests).

parseNextGuest([], Guests) ->
    Guests;
parseNextGuest(Rows, Guests) ->
    [First | TheRest] = Rows,
    Guest = parseGuest(First, Guests),
    Name = maps:get(name, Guest),
    parseNextGuest(TheRest, maps:put(Name, Guest, Guests)).

createGuestMap(IncludeMe) ->
    if
        IncludeMe ->
            #{name => "Me", rules => []};
        true ->
            #{}
    end.
