module Components.UI.Col exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

type alias Config msg =
    { screen : Screen
    , col : Int
    , offset : Maybe Offset
    , attr : List ( Attribute msg )
    }

type alias Offset = 
    { screen: Screen, col: Int }

type Screen
    = XS
    | SM
    | MD
    | LG
    | XL
    | RT

view : Config msg -> List ( Html msg ) -> Html msg
view config kids =
    let
        
        size = 
            getScreenStr config.screen
            
        -- offsetSize =
        offsetClass =
            case config.offset of
                Just offset ->
                    "col--"++ getScreenStr offset.screen ++"--"++ String.fromInt offset.col++"--offset"
                Nothing ->
                    ""

        colClass = "col--"++size++"--"++ String.fromInt config.col

        classes = String.join " " ["col", colClass, offsetClass]

        attrs = class classes :: config.attr
    in
    div (attrs) kids


getScreenStr : Screen -> String
getScreenStr screen =
    case screen of
        XS ->
            "sm"
        SM ->
            "sm"
        MD ->
            "md"
        LG ->
            "lg"
        XL ->
            "xl"
        RT ->
            "rt"