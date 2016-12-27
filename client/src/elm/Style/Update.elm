module Style.Update exposing (..)

import Style.Messages exposing (..)
import Style.Models exposing (..)
import Time exposing (Time)
import Date


update : Msg -> StyleModel -> ( StyleModel, Cmd Msg )
update msg model =
    case msg of
        ToggleStyle ->
            ( { model | style = (otherStyle model.style) }, Cmd.none )

        SetStyleBasedOnTime time ->
            ( { model | style = (getStyleFromTime time) }, Cmd.none )


otherStyle : Style -> Style
otherStyle style =
    case style of
        Light ->
            Dark

        Dark ->
            Light


getStyleFromTime : Time -> Style
getStyleFromTime time =
    let
        datetime =
            Date.fromTime time

        hour =
            Debug.log (toString <| Date.hour datetime) Date.hour datetime
    in
        if hour <= 9 || hour >= 18 then
            Dark
        else
            Light
