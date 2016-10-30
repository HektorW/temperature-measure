module Update exposing (..)

import Messages exposing (..)
import Models exposing(..)
import Measurements.Update

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    MeasurementsMsg subMsg ->
      let
        ( updatedMeasurementsModel, cmd ) =
          Measurements.Update.update subMsg model.measurementsModel
      in
        ( { model | measurementsModel = updatedMeasurementsModel }, Cmd.map MeasurementsMsg cmd )
