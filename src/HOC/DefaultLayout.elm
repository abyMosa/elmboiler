module HOC.DefaultLayout exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Components.Header as Header
import Components.Footer as Footer


type alias Details msg =
    { title : String
    , attrs : List (Attribute msg)
    , kids : List (Html msg)
    }

-- VIEW
view : (a -> msg) ->  Details a -> { title: String, body: List(Html msg) }
view contentMsg details =
    { title = details.title
    , body = 
        [ Header.view ( Header.Config False [] )
        , Html.map contentMsg <| 
                div (class "defaultlayout" :: details.attrs) details.kids
        , Footer.view
        ]
    }