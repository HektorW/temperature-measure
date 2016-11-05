module Messages exposing (..)

import Measurements.Messages
import Style.Messages

type Msg
  = MeasurementsMsg Measurements.Messages.Msg
  | StyleMsg Style.Messages.Msg
