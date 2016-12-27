module Style.Commands exposing (..)

import Style.Messages exposing (..)
import Time
import Task


checkCurrentTime : Cmd Msg
checkCurrentTime =
    Time.now
        |> Task.perform
            SetStyleBasedOnTime
