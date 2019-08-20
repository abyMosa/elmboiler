module Components.UI.Col exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

type alias Config msg =
    { screen : Screen
    , col : Int
    , offset: Offset
    , attr : List ( Attribute msg )
    , kids : List ( Html msg )
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

view : Config msg -> Html msg
view config =
    let
        
        size = 
            getScreenStr config.screen
            
        offsetSize =
            getScreenStr config.offset.screen
            
        colClass = "col--"++size++"--"++ String.fromInt config.col
        offsetClass = "col--"++offsetSize++"--"++ String.fromInt config.offset.col++"--offset"

        classes = String.join " " ["col", colClass, offsetClass]

        attrs = class classes :: config.attr
    in
    div (attrs) config.kids


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