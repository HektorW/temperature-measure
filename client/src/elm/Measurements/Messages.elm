module Measurements.Messages exposing (..)

import Http
import Measurements.Models exposing (Measurement)


type Msg
    = FetchLatest (Result Http.Error (List Measurement))
