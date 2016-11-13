module View exposing (..)

import Measurements.Models exposing (Measurement, MeasurementsModel)
import Measurements.View
import Style.Models exposing (..)
import Style.View
import Models exposing (..)
import Messages exposing (..)
import Graph

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App

view : Model -> Html Msg
view model =
  div [ class ( styleClass model.styleModel.style ) ]
    [ header []
        [ Html.App.map StyleMsg ( Style.View.view model.styleModel )
        , h1 [] [ text "Temperature" ]
        ]
    , main' []
        [ Html.App.map MeasurementsMsg ( Measurements.View.view model.measurementsModel )
        , Graph.render 400 200 ( graphValues model.measurementsModel )
        ]
    ]


graphValues : MeasurementsModel -> List Float
graphValues model =
  model.measurements
    |> List.map ( \measurement -> measurement.temperature )
    |> List.reverse


styleClass : Style -> String
styleClass style =
  case style of
    Light ->
      "app-light"
    Dark ->
      "app-dark"
