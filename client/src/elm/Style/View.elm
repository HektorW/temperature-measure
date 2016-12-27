module Style.View exposing (..)

import Style.Messages exposing (..)
import Style.Models exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


view : StyleModel -> Html Msg
view model =
    button [ class "style", onClick ToggleStyle ] []
