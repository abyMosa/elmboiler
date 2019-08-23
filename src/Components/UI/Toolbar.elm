module Components.UI.Toolbar exposing (..)
 
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
 
 
 
type alias Config msg =
    { theme : Theme
    , elivation : Maybe Int
    , size : Maybe Size
    , attr : List( Attribute msg )
    }

type Size
    = Lg
    | Sm

type Theme
    = Primary
    | Error
    | Info
    | Warning
    | Dark
    | Success
    | Indigo
    | DarkGray

view : Config msg -> List (Html msg) -> Html msg
view config kids =
    let
        classes = getClasses config 
        attrs = class classes :: config.attr
    in
    div (attrs) kids

-- HELPERS
getClasses : Config msg -> String
getClasses config =
    String.join " " <| 
        addSizeClasses config <| 
            addElivationClasses config <|
                addThemeClasses config ["ab-toolbar"]


addThemeClasses : Config msg -> List String -> List String
addThemeClasses config classes =
    let
        value = 
            case config.theme of
                Primary ->
                    List.append classes ["primary"]
                Error ->
                    List.append classes ["error"]
                Info ->
                    List.append classes ["info"]
                Warning ->
                    List.append classes ["warning"]
                Dark ->
                    List.append classes ["dark"]
                Success ->
                    List.append classes ["success"]
                Indigo ->
                    List.append classes ["indigo"]
                DarkGray ->
                    List.append classes ["darkGray"]

    in
    value

addElivationClasses : Config msg -> List String -> List String
addElivationClasses config classes =
    let
        value = 
            case config.elivation of
                Just elv ->
                    case elv of
                        1 ->
                            List.append classes ["ab-toolbar-elivated"]
                        2 ->
                            List.append classes ["ab-toolbar-elivated2"]
                        _ -> 
                            List.append classes ["ab-toolbar-elivated"++ String.fromInt elv]
                Nothing -> 
                    List.append classes [""]
    in
    value

addSizeClasses : Config msg -> List String -> List String
addSizeClasses config classes =
    let
        value = 
            case config.size of
                Just size ->
                    case size of
                        Lg ->
                            List.append classes ["ab-toolbar--large"]
                        Sm ->
                            List.append classes ["ab-toolbar-small"]
                Nothing -> 
                    List.append classes [""]
    in
    value