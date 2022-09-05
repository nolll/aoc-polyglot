' using System.Collections.Generic;
' using System.Linq;
' using Core.Common.Combinatorics;
' using Core.Common.Strings;

Public Class RouteCalculator
    Private _distanceDictionary As Dictionary(Of String, String)
    Public ShortestDistance As Integer
    Public LongestDistance As Integer

    Public Sub Init(input As String)
        Dim distances = GetDistances(input)
'         var distances = GetDistances(input);
'         _distanceDictionary = GetDistanceDictionary(distances);
'         var locations = GetLocations(distances);
'         var routes = GetRoutes(locations);
'         ShortestDistance = FindShortestDistance(routes);
'         LongestDistance = FindLongestDistance(routes);
    End Sub

'     private int FindShortestDistance(List<List<string>> routes)
'     {
'         int? shortestRoute = null;
'         foreach (var route in routes)
'         {
'             var routeLength = CalculateRouteLength(route.ToList());
'             if (shortestRoute == null || routeLength < shortestRoute.Value)
'                 shortestRoute = routeLength;
'         }
'         return shortestRoute ?? 0;
'     }

'     private int FindLongestDistance(List<List<string>> routes)
'     {
'         int? longestRoute = null;
'         foreach (var route in routes)
'         {
'             var routeLength = CalculateRouteLength(route.ToList());
'             if (longestRoute == null || routeLength > longestRoute.Value)
'                 longestRoute = routeLength;
'         }
'         return longestRoute ?? 0;
'     }

'     private int CalculateRouteLength(IList<string> route)
'     {
'         var totalDistance = 0;
'         for (var i = 0; i < route.Count - 1; i++)
'         {
'             var from = route[i];
'             var to = route[i + 1];
'             var key = GetKey(from, to);
'             var distance = _distanceDictionary[key];
'             totalDistance += distance;
'         }

'         return totalDistance;
'     }

'     private List<List<string>> GetRoutes(IList<string> locations)
'     {
'         return PermutationGenerator.GetPermutations(locations).Select(o => o.ToList()).ToList();
'     }

'     private IList<string> GetLocations(IList<Distance> distances)
'     {
'         var locations = new List<string>();
'         foreach (var distance in distances)
'         {
'             if(!locations.Contains(distance.From))
'                 locations.Add(distance.From);
'             if (!locations.Contains(distance.To))
'                 locations.Add(distance.To);
'         }

'         return locations;
'     }

'     private IDictionary<string, int> GetDistanceDictionary(IList<Distance> distances)
'     {
'         var dictionary = new Dictionary<string, int>();
'         foreach (var distance in distances)
'         {
'             dictionary.Add(GetKey(distance.From, distance.To), distance.Dist);
'             dictionary.Add(GetKey(distance.To, distance.From), distance.Dist);
'         }

'         return dictionary;
'     }

    Private Function GetKey(a As String, b As String)
        Return $"{a}->{b}"
    End Function

    Private Function GetDistances(input as String)
        Dim lines() As String = input.Split(Environment.NewLine)
        return lines.Select(Function(l) CreateDistance(l)).ToList()
    End Function

    Private Function CreateDistance(s As String) As Distance
        Dim distance As New Distance
        Dim parts() As String = Split(Trim(s))
        distance.A = parts(0)
        distance.B = parts(2)
        distance.Dist = Integer.Parse(parts(4))
        return distance
    End Function

End Class