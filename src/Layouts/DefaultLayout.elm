module Layouts.DefaultLayout exposing (..)

import About as About

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Decode as Decode

import Routes


type alias Model =
    { aboutModel : About.Model
    , isHeaderFixed : Bool
    , headerHeight : Float
    , footerHeight : Float
    }

type Msg
    = AboutMsg About.Msg
    | CompLoaded Float Float



-- https://stackoverflow.com/questions/48551782/elm-get-the-size-of-an-image
init : Model
init =    
    { aboutModel = About.init
    ,isHeaderFixed = False
    , headerHeight = 0.0
    , footerHeight = 0.0
    }

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CompLoaded header footer ->
            ({ model | headerHeight = header, footerHeight = footer } , Cmd.none)

        _ ->
            (model, Cmd.none)


-- VIEW 
view : Routes.Route -> Model -> Html Msg
view route model =
    let
        viewPage toMsg pageView pageModel =
            Html.map toMsg <| pageView pageModel
        
        kids = 
            case route of
                Routes.About ->
                    viewPage AboutMsg About.view model.aboutModel
                _ -> 
                    div[][text ""]
                    
    in    
    div [ class "center app" ]
    [ viewHeader
    , div[class "defaultlayout"] [ kids ]
    , viewFooter
    ]

-- VIEW HEADER
viewHeader : Html msg
viewHeader =
  div
    [ style "backgroundColor" "#eeeeee"
    ]
    [ div [class "center"]
        [ h1 [ class "header", style "margin" "0px" ] [ text "Header" ]
        , ul []
            [ li [] [ createLink "" ]
            , li [] [ createLink "about" ]
            ]
        ]
    ]


viewFooter : Html msg
viewFooter =
  div [class "footer"]
    [ text "All code for this site is open source and written in Elm. "
    , a [ class "grey-link", href "https://github.com/elm/package.elm-lang.org/" ] [ text "Check it out" ]
    , text "! — © 2012-present Evan Czaplicki"
    ]


createLink : String -> Html msg
createLink path =
    a [ href ("/" ++ path) ] 
    [ 
        if path == "" then 
            text "Home"
        else
            text path
    ]
