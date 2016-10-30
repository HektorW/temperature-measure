module Main exposing (..)

import Models exposing (..)
import Messages exposing (..)
import Update exposing (..)
import View exposing (..)
import Measurements.Commands exposing (fetchLatest)

import Html.App as App


init : (Model, Cmd Msg)
init =
  (initialModel, Cmd.map MeasurementsMsg fetchLatest)


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


main : Program Never
main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
