module Update exposing (..)

import Messages exposing (..)
import Models exposing(..)
import Measurements.Update
import Style.Update

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    MeasurementsMsg subMsg ->
      let
        ( updatedMeasurementsModel, cmd ) =
          Measurements.Update.update subMsg model.measurementsModel
      in
        ( { model | measurementsModel = updatedMeasurementsModel }, Cmd.map MeasurementsMsg cmd )
    StyleMsg subMsg ->
      let
        ( updatedStyleModel, cmd ) =
          Style.Update.update subMsg model.styleModel
      in
        ( { model | styleModel = updatedStyleModel }, Cmd.map StyleMsg cmd )
