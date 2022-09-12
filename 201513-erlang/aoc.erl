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

run() ->
    Rows = readlines("input.txt"),
    Guests = parseGuests(Rows, false),
    Keys = maps:keys(Guests),
    Length = length(Keys),
    io:fwrite("guests: ~w~n", [Length]).

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
