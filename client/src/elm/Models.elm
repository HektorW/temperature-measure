module Models exposing (..)

import Measurements.Models exposing (MeasurementsModel, initialMeasurementsModel)
import Style.Models exposing (StyleModel, initialStyleModel)

type alias Model =
  { measurementsModel : MeasurementsModel
  , styleModel : StyleModel
  }

initialModel : Model
initialModel =
  { measurementsModel = initialMeasurementsModel
  , styleModel = initialStyleModel
  }
