module Models exposing (..)

import Measurements.Models exposing (MeasurementsModel, initialMeasurementsModel)

type alias Model =
  { measurementsModel : MeasurementsModel
  }

initialModel : Model
initialModel =
  { measurementsModel = initialMeasurementsModel
  }
