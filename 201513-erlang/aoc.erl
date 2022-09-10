-module(aoc).
-export([run/0]).

readfile(FileName) ->
    {ok, Binary} = file:read_file(FileName),
    string:tokens(erlang:binary_to_list(Binary), "\n").

run() ->
    Lines = readfile("input.txt"),
    Length = length(Lines),
    io:fwrite("lines: ~w~n", [Length]).

% parseGuests(input, includeMe) ->
%     Rules = readInput(input).
%     Guests = new Dictionary<string, DinnerGuest>().

% if (includeMe)
% {
%     const string name = "Me";
%     guests.Add(name, new DinnerGuest(name));
% }

% foreach (var r in rules)
% {
%     var parts = r.TrimEnd('.').Split(' ');
%     var name = parts[0];
%     var sign = parts[2] == "lose" ? -1 : 1;
%     var happiness = sign * int.Parse(parts[3]);
%     var otherName = parts[10];
%     var rule = new DinnerGuestRule(otherName, happiness);
%     if (!guests.TryGetValue(name, out var guest))
%     {
%         guest = new DinnerGuest(name);
%         guests.Add(name, guest);
%     }

%     guest.AddRule(rule);
% }

% Guests.

% dinnerTable(input, includeMe) ->
%     Guests = parseGuests(input, includeMe).
%     var names = guests.Keys;
%     var nameLists = PermutationGenerator.GetPermutations(names.ToList());
%     var happiness = nameLists.Select(nl => CalculateHappiness(nl.Select(p => guests[p]).ToList()));

%     HappinessChange = happiness.Max();

% calculateHappiness(guests) ->
%     var happiness = 0;
%     for (var i = 0; i < guests.Count; i++)
%     {
%         var guest = guests[i];
%         var nextGuestIndex = i + 1 >= guests.Count ? 0 : i + 1;
%         var prevGuestIndex = i - 1 < 0 ? guests.Count - 1 : i - 1;
%         var nextGuest = guests[nextGuestIndex];
%         var prevGuest = guests[prevGuestIndex];
%         var nextGuestHappiness = guest.GetHappiness(nextGuest.Name);
%         var prevGuestHappiness = guest.GetHappiness(prevGuest.Name);
%         happiness += nextGuestHappiness + prevGuestHappiness;
%     }
%     return happiness;

% getPermutations(list, length) ->
%     if (length == 1) return list.Select(t => new[] { t });

%     return GetPermutations(list, list.length - 1)
%         .SelectMany(t => list.Where(e => !t.Contains(e)),
%             (t1, t2) => t1.Concat(new[] { t2 }));
