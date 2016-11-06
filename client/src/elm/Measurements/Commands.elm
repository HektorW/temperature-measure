module Measurements.Commands exposing (..)

import Measurements.Messages exposing (..)
import Measurements.Models exposing (..)

import Http
import Task
import Date exposing (Date, fromString)
import Json.Decode as Decode exposing ((:=), andThen)


fetchLatest : Cmd Msg
fetchLatest =
  Http.get collectionDecoder fetchLatestUrl
   |> Task.perform FetchLatestError FetchLatestSuccess


fetchLatestUrl : String
fetchLatestUrl =
  "/api/temperature?count=15"

-- Decoders

collectionDecoder : Decode.Decoder (List Measurement)
collectionDecoder =
  Decode.list measurementDecoder


measurementDecoder : Decode.Decoder Measurement
measurementDecoder =
  Decode.object3 Measurement
    ("temperature" := Decode.float)
    ("time" := dateDecoder)
    ("location" := Decode.string)


dateDecoder : Decode.Decoder Date
dateDecoder = Decode.customDecoder Decode.string Date.fromString
