module Graph exposing (render)

import Html exposing (div)
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


type alias GraphConfig =
  { minValue : Value
  , maxValue : Value
  , lineWidth : LineWidth
  , width : Width
  , height : Height
  }


render : Width -> Height -> Values -> Svg a
render graphWidth graphHeight values =
  let
    config =
      { minValue = minValue values
      , maxValue = maxValue values
      , lineWidth = lineWidth values graphWidth
      , width = graphWidth
      , height = graphHeight
      }
  in
    div [ class "graph" ]
      [ div [ class "line" ] [ text <| ( toString config.maxValue ) ++ "°" ]
      , svg [ viewBox ( "0 0 " ++ ( toString graphWidth ) ++ " " ++ ( toString graphHeight ) ) ]
          [ Svg.path
              [ strokeWidth "1"
              , fill "none"
              , d ( getPath values config )
              ]
              []
          ]
      , div [ class "line" ] [ text <| ( toString config.minValue ) ++ "°" ]
      ]


getPath : Values -> GraphConfig -> String
getPath values config =
  values
    |> List.indexedMap (\index value -> ( pathForValue value index config ))
    |> List.foldr ( \a b -> a ++ " " ++ b ) ""


pathForValue : Value -> Index -> GraphConfig -> String
pathForValue value index config =
  let
    y = valueY value config
  in
    if index == 0 then
      "M0 " ++ toString ( y )
    else
      "L" ++ ( toString ( valueX index config.lineWidth ) ) ++ " " ++ toString y


lineWidth : Values -> Width -> LineWidth
lineWidth values width =
  ( toFloat width ) / ( toFloat ( ( List.length values ) - 1 ) )


valueX : Index -> LineWidth -> X
valueX index lineWidth =
  ( toFloat index ) * lineWidth


valueY : Value -> GraphConfig -> Y
valueY value config =
  let
    height = config.height
    minY = config.minValue
    maxY = config.maxValue
  in
    ( toFloat height ) / ( maxY - minY ) * ( maxY - value )


minValue : Values -> Value
minValue values =
  let
    min = List.minimum values
  in
    case min of
      Just value ->
        value |> floor |> toFloat
      Nothing ->
        15


maxValue : Values -> Value
maxValue values =
  let
    max = List.maximum values
  in
    case max of
      Just value ->
        value |> (+) 1 |> floor |> toFloat
      Nothing ->
        25
