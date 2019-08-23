module Components.UI.Container exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


view : List ( Attribute msg ) -> List ( Html msg ) -> Html msg
view attr kids =
    div (class "container" :: attr ) kids
