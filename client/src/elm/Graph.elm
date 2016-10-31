module Graph exposing (render)

import Svg exposing (..)
import Svg.Attributes exposing (..)

type alias Width = Int
type alias Height = Int
type alias Value = Float
type alias Values = List Value
type alias Index = Int
type alias LineWidth = Float
type alias X = Float
type alias Y = Float

render : Width -> Height -> Values -> Svg a
render graphWidth graphHeight values =
  svg [ width ( toString graphWidth ), height ( toString graphHeight ) ]
    [ Svg.path
        [ strokeWidth "1"
        , stroke "#000"
        , fill "none"
        , d ( getPath values graphWidth graphHeight )
        ]
        []
    ]


getPath : Values -> Width -> Height -> String
getPath values width height =
  let
    lineWidth = ( toFloat width ) / ( toFloat ( ( List.length values ) - 1 ) )
  in
    values
      |> List.indexedMap (\index value -> ( pathForValue index value lineWidth height ))
      |> List.foldr ( \a b -> a ++ " " ++ b ) ""



pathForValue : Index -> Value -> LineWidth -> Height -> String
pathForValue index value lineWidth height =
  let
    y = valueY value height
  in
    if index == 0 then
      "M0 " ++ toString ( y )
    else
      "L" ++ ( toString ( valueX index lineWidth ) ) ++ " " ++ toString y


valueX : Index -> LineWidth -> X
valueX index lineWidth =
  ( toFloat index ) * lineWidth


valueY : Value -> Height -> Y
valueY value height =
  let
    minY = 15
    maxY = 25
  in
    ( toFloat height ) / ( maxY - minY ) * ( maxY - value )
