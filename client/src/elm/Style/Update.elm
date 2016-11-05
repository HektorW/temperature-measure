module Style.Update exposing (..)

import Style.Messages exposing (..)
import Style.Models exposing (..)

update : Msg -> StyleModel -> (StyleModel, Cmd Msg)
update msg model =
  case msg of
    ToggleStyle ->
      ( { model | style = ( otherStyle model.style ) }, Cmd.none )

otherStyle : Style -> Style
otherStyle style =
  case style of
    Light ->
      Dark
    Dark ->
      Light

