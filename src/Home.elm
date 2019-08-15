module Home exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

type Msg
    = NoOp

type alias Model = 
    { title: String }


-- VIEW

view : Html Msg
view =
    div[][text "Home"]
