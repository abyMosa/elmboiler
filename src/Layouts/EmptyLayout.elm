module Layouts.EmptyLayout exposing (..)


import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Decode as D
import Routes

type alias Details msg =
    { title : String
    , attrs : List (Attribute msg)
    , kids : List (Html msg)
    }

-- VIEW
view : (a -> msg) ->  Details a -> { title: String, body: Html msg }
-- view : (a -> msg) ->  Details a -> Browser.Document msg
view contentMsg details =
    { title = details.title
    , body = 
            Html.map contentMsg <| 
                div (class "app emptylayout" :: details.attrs) details.kids
    }