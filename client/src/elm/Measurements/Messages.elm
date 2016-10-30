module Measurements.Messages exposing (..)

import Http
import Measurements.Models exposing (Measurement)

type Msg
  = FetchLatestSuccess (List Measurement)
  | FetchLatestError Http.Error
