module Components.UI.Row exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

type alias Config msg =
    { attr : List ( Attribute msg )
    , kids : List ( Html msg )
    }


view : List ( Attribute msg ) -> List ( Html msg ) -> Html msg
view attr kids =
    div (class "layout" :: attr ) kids
