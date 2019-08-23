module Components.Header exposing (..)
 
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


import Components.UI.Toolbar as Toolbar
import Components.UI.Container as Container
import Components.UI.Row as Row
import Components.UI.Col as Col
import Components.UI.NavigationItems as NavigationItems

type alias Config msg =
    { fluid : Bool
    , attr : List ( Attribute msg )
    }

view : Config msg -> Html msg
view config =
    let
        items =
            [ { title = "Home", link = "/" }
            , { title = "About", link = "/about" }
            , { title = "Todo", link = "/todo" }
            ]    
        attrs =
            class "header" :: config.attr
        fluidClass =
            if config.fluid then 
                "container--wide"
            else
                ""  
    in
    
    div attrs [
        Toolbar.view (Toolbar.Config Toolbar.Dark (Just 1) Nothing [ ]) 
        [ Container.view [ class fluidClass ]
            [ Row.view []
                [ Col.view (Col.Config Col.MD 3 Nothing [class "df f-aa-center"]) 
                    [ a [href "/", class "logo"]
                        [h2[class "thin"][ text "TodoApp" ]
                        ]
                    ]
                , Col.view (Col.Config Col.MD 9 Nothing [])
                    [ 
                        NavigationItems.view [] items 
                    ]
                ]
                
            ]
        ]
    ]
