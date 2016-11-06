module Measurements.View exposing (..)

import Measurements.Messages exposing (..)
import Measurements.Models exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Date.Extra.Config.Config_en_gb exposing (config)
import Date.Extra.Format exposing (format)

view : MeasurementsModel -> Html Msg
view model =
  div [ class "latest-temperature" ]
    [ text ( latestTemperatureString model )
    , span [ class "sign" ] [ text "°" ]
    , small [ class "date" ] [ text ( latestDateString model ) ]
    ]


latestDateString : MeasurementsModel -> String
latestDateString model =
  let
    latest = latestMeasurement model
  in
    case latest of
      Just measurement ->
        format config "%b %-d, %H:%M" measurement.time
      Nothing ->
        ""


latestTemperatureString : MeasurementsModel -> String
latestTemperatureString model =
  let
    latest = latestMeasurement model
  in
    case latest of
      Just measurement ->
        toString ( roundTo 1 measurement.temperature )
      Nothing ->
        "-"


latestMeasurement : MeasurementsModel -> Maybe Measurement
latestMeasurement model =
  List.head model.measurements


roundTo : Int -> Float -> Float
roundTo places =
  let factor = 10 ^ places
  in (*) factor >> round >> toFloat >> (\n -> n / factor)
