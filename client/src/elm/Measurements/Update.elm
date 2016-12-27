module Measurements.Update exposing (..)

import Measurements.Messages exposing (..)
import Measurements.Models exposing (..)


update : Msg -> MeasurementsModel -> ( MeasurementsModel, Cmd Msg )
update msg measurementsModel =
    case msg of
        FetchLatest (Ok newMeasurements) ->
            ( { measurementsModel | measurements = newMeasurements }, Cmd.none )

        FetchLatest (Err httpError) ->
            ( { measurementsModel | fetchLatestError = Just httpError }, Cmd.none )
