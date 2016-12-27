module Main exposing (..)

import Models exposing (..)
import Messages exposing (..)
import Update exposing (..)
import View exposing (..)
import Measurements.Commands exposing (fetchLatest)
import Style.Commands exposing (checkCurrentTime)
import Html


init : ( Model, Cmd Msg )
init =
    ( initialModel, initialCommands )


initialCommands : Cmd Msg
initialCommands =
    Cmd.batch
        [ Cmd.map MeasurementsMsg fetchLatest
        , Cmd.map StyleMsg checkCurrentTime
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
