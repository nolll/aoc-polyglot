' using System.Collections.Generic;
' using System.Linq;
' using Core.Common.Combinatorics;
' using Core.Common.Strings;

Public Class RouteCalculator
    Private _distanceDictionary As Dictionary(Of String, Integer)
    Public ShortestDistance As Integer
    Public LongestDistance As Integer

    Public Sub Init(input As String)
        Dim distances = GetDistances(input)
        _distanceDictionary = GetDistanceDictionary(distances)
        Dim locations = GetLocations(distances)
        Dim routes = GetRoutes(locations)
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

    Private Function GetLocations(distances As List(Of Distance)) As List(Of String)
        Dim locations As New List(Of String)
        For Each distance in distances
            If Not locations.Contains(distance.A)
                locations.Add(distance.A)
            End If
            If Not locations.Contains(distance.B)
                locations.Add(distance.B)
            End If
        Next

        Return locations
    End Function

    Private Function GetDistanceDictionary(distances As List(Of Distance)) As Dictionary(Of String, Integer)
        Dim dictionary As New Dictionary(Of String, Integer)
        For Each distance In distances
            dictionary.Add(GetKey(distance.A, distance.B), distance.Dist)
            dictionary.Add(GetKey(distance.B, distance.A), distance.Dist)
        Next

        Return dictionary
    End Function

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

    Private Function GetRoutes(locations As List(Of String)) As List(Of List(Of String))
        Return GetPermutations(locations).Select(Function(o) o.ToList()).ToList()
    End Function

    Private Function GetPermutations(strings As List(Of String)) As List(Of List(Of String))
        Return GetPermutations(strings, strings.Count).Select(Function(o) o.ToList()).ToList()
    End Function

    Private Function GetPermutations(list As List(Of String), length As Integer) As List(Of List(Of string))
        If length = 1
            Return list.Select(Function(t) New List(Of String) From {t}).ToList()
        End If

        Return GetPermutations(list, length - 1).SelectMany(Function(t) list.Where(Function(e) Not t.Contains(e)).ToList(), Function(t1, t2) t1.Concat(New List(Of String) From {t2}).ToList()).ToList()
    End Function
End Class