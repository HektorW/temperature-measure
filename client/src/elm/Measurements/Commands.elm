module Measurements.Commands exposing (..)

import Measurements.Messages exposing (..)
import Measurements.Models exposing (..)
import Http
import Task
import Json.Decode as Decode exposing (field)
import Json.Decode.Extra


fetchLatest : Cmd Msg
fetchLatest =
    Http.get fetchLatestUrl collectionDecoder
        |> Http.toTask
        |> Task.attempt FetchLatest


fetchLatestUrl : String
fetchLatestUrl =
    "/api/temperature?count=15"



-- Decoders


collectionDecoder : Decode.Decoder (List Measurement)
collectionDecoder =
    Decode.list measurementDecoder


measurementDecoder : Decode.Decoder Measurement
measurementDecoder =
    Decode.map3 Measurement
        (field "temperature" Decode.float)
        (field "time" Json.Decode.Extra.date)
        (field "location" Decode.string)
