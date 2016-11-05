module View exposing (..)

import Measurements.Models exposing (Measurement, MeasurementsModel)
import Measurements.View
import Style.Models exposing (..)
import Style.View
import Models exposing (..)
import Messages exposing (..)
import Graph

import Http
import Http
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App
import Date.Extra.Config.Config_en_gb exposing (config)
import Date.Extra.Format exposing (format)

view : Model -> Html Msg
view model =
  div [ class ( styleClass model.styleModel.style ) ]
    [ header []
        [ Html.App.map StyleMsg ( Style.View.view model.styleModel )
        , h1 [] [ text "Temperature" ]
        ]
    , main' []
        [ Html.App.map MeasurementsMsg ( Measurements.View.view model.measurementsModel )
        , Graph.render 400 200 ( List.map ( \measurement -> measurement.temperature ) model.measurementsModel.measurements )
        ]
    ]


styleClass : Style -> String
styleClass style =
  case style of
    Light ->
      "app-light"
    Dark ->
      "app-dark"


renderMeasurements : MeasurementsModel -> Html Msg
renderMeasurements model =
  case model.fetchLatestError of
    Just error ->
      renderError error

    Nothing ->
      renderList model.measurements


renderError : Http.Error -> Html Msg
renderError error =
  case error of
    Http.Timeout ->
      div [] [ text "Network timed out" ]

    Http.NetworkError ->
      div [] [ text "Network error" ]

    Http.UnexpectedPayload str ->
      div []
        [ div [] [ text "Unexpected payload" ]
        , div [] [ text str ]
        ]

    Http.BadResponse status str ->
      div []
        [ div [] [ text "Bad response" ]
        , div [] [ text ("Status " ++ (toString status)) ]
        , div [] [ text str ]
        ]


renderList : List Measurement -> Html Msg
renderList measurements =
  div []
    [ h2 [] [ text "Entries" ]
    , ul [] ( List.map renderRow measurements )
    ]


renderRow : Measurement -> Html Msg
renderRow measurement =
  li []
    [ span [] [ text ( "Temperature: " ++ ( toString measurement.temperature ) ++ "°C" ) ]
    , span [] [ text ( ", Timestamp: " ++ ( format config "%b %-d, %H:%M" measurement.time ) ) ]
    ]


