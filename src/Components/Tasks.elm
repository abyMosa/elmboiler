module Components.Tasks exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Components.UI.Container as Container
import Components.UI.Row as Row
import Components.UI.Col as Col

type alias Model =
    {}

type Msg
    = NoOp



init : ( Model, Cmd Msg ) 
init =
    ( { }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div[]
    [
    
    ]
