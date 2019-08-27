module HOC.DefaultLayout exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Components.Header as Header
import Components.Footer as Footer

-- VIEW
view : (a -> msg) ->  List(Html a) -> List (Html msg)
view contentMsg kids =
    [ Header.view ( Header.Config False [] )
    , Html.map contentMsg <| 
            div [class "defaultlayout" ] kids
    , Footer.view
    ]