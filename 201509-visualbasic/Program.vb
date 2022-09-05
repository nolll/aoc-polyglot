Imports System
Imports System.IO

Module Program
    Sub Main(args As String())
        Dim calculator As new RouteCalculator
        Dim input as String = ReadInput()
        calculator.Init(input)
    End Sub

    Private Function ReadInput()
        Return File.ReadAllText("input.txt")
    End Function
End Module
