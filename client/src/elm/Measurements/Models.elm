module Measurements.Models exposing (..)

import Http
import Date exposing (Date)


type alias Location =
    String


type alias Temperature =
    Float


type alias Measurement =
    { temperature : Temperature
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
