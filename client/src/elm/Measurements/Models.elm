module Measurements.Models exposing (..)

import Http

type alias Measurement =
  { temperature : Float
  , time : String
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
