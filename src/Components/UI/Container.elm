module Components.UI.Container exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

type alias Config msg =
    { attr : List ( Attribute msg )
    , kids : List ( Html msg )
    }


view : Config msg -> Html msg
view config =
    div (class "container" :: config.attr ) config.kids

-- view : (a-> msg) -> Config a -> Html msg
-- view toMsg config =
--     Html.map toMsg <|
--         div (class "container" :: config.attr ) config.kids