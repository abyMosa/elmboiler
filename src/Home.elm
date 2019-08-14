module Home exposing (..)


import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Decode as D

type Msg
    = NoOp

type alias Model = 
    { title: String }


-- VIEW

view : Html Msg
view =
    div[][text "Home"]
