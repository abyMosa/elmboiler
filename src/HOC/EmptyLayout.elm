module HOC.EmptyLayout exposing (..)


import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Routes


-- VIEW
view : (a -> msg) ->  List(Html a) -> List (Html msg)
view contentMsg kids =
    [ Html.map contentMsg <| 
                div [class "app emptylayout" ] kids
    ]