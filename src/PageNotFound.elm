module PageNotFound exposing (Msg(..), view)

import Html exposing (..)
import Html.Attributes exposing (..)

type Msg
    = NotFoundMsg

type alias Model = 
    { title: String }


-- VIEW

view : Html Msg
view =
    div[][text "Page not found"]
