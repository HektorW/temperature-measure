module Measurements.View exposing (..)

import Measurements.Messages exposing (..)
import Measurements.Models exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Date.Extra.Config.Config_en_gb exposing (config)
import Date.Extra.Format exposing (format)
import Exts.Float exposing (roundTo)


view : MeasurementsModel -> Html Msg
view model =
    div [ class "latest-temperature" ]
        [ text (latestTemperatureString model)
        , span [ class "sign" ] [ text "°" ]
        , small [ class "date" ] [ text (latestDateString model) ]
        ]


latestDateString : MeasurementsModel -> String
latestDateString model =
    let
        latest =
            latestMeasurement model
    in
        case latest of
            Just measurement ->
                format config "%b %-d, %H:%M" measurement.time

            Nothing ->
                ""


latestTemperature : MeasurementsModel -> Float
latestTemperature model =
    let
        latest =
            latestMeasurement model
    in
        case latest of
            Just measurement ->
                measurement.temperature

            Nothing ->
                0.0


latestTemperatureString : MeasurementsModel -> String
latestTemperatureString model =
    latestTemperature model
        |> oneDecimal
        |> toString


latestMeasurement : MeasurementsModel -> Maybe Measurement
latestMeasurement model =
    List.head model.measurements


oneDecimal : Float -> Float
oneDecimal =
    roundTo 1
