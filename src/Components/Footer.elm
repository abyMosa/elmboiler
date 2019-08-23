module Components.Footer exposing (..)
 
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


import Components.UI.Toolbar as Toolbar
import Components.UI.Container as Container
import Components.UI.Row as Row
-- import Components.UI.Col as Col
-- import Components.UI.NavigationItems as NavigationItems

view : Html msg
view =
    div [] [
        Toolbar.view (Toolbar.Config Toolbar.Dark Nothing Nothing []) 
        [ Container.view []
            [ Row.view []
                [ text "All code for this site is open source and written in Elm. "
                , a [ class "grey-link", href "https://github.com/elm/package.elm-lang.org/" ] [ text "Check it out" ]
                , text "! — © 2012-present Evan Czaplicki"            
                ]
            ]
        ]
    ]
