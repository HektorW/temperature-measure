module Measurements.Models exposing (..)

import Http
import Date exposing (Date)

type alias Measurement =
  { temperature : Float
  , time : Date
  , location : String
  }

type alias MeasurementsModel =
  { measurements : List Measurement
  , fetchLatestError : Maybe Http.Error
  }

initialMeasurementsModel : MeasurementsModel
initialMeasurementsModel =
  { measurements = []
  , fetchLatestError = Nothing
  }
