module Style.Models exposing (..)

type Style
  = Light
  | Dark

type alias StyleModel =
  { style : Style
  }

initialStyleModel : StyleModel
initialStyleModel =
  { style = Light
  }
