module Layouts.DefaultLayout exposing (..)

import About as About

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on)
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
    | HeaderLoaded Float
    | FooterLoaded Float



-- https://stackoverflow.com/questions/48551782/elm-get-the-size-of-an-image
-- init : ( Model, Cmd Msg )
init : Model
init =    
    -- ( 
        { aboutModel = About.init
        ,isHeaderFixed = False
        , headerHeight = 0.0
        , footerHeight = 0.0
        }
    -- , Cmd.none
    -- )

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HeaderLoaded header ->
            let
                _ = Debug.log "header" header
            in
            ({ model | headerHeight = header } , Cmd.none)
        FooterLoaded footer ->
            ({ model | footerHeight = footer } , Cmd.none)

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


decodeHeader msg =
    Decode.map msg <|
        Decode.field "target" <|
                (Decode.field "height" Decode.float)


-- VIEW HEADER
viewHeader : Html Msg
viewHeader =
    div [ style "backgroundColor" "#eeeeee", on "load" (decodeHeader HeaderLoaded) ]
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
