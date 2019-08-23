module Pages.About exposing (..)
 
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


view : Model -> { title: String, attrs: List(Attribute Msg), kids: List(Html Msg) }
view model =
    { title = "About Page" 
        , attrs = [class "py-5"]
        , kids = 
            [ Container.view []
                [ Row.view []
                    [ h1[class "mb-4"][ text "About Us" ]
                    , p[][ text "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."]
                    ]
                ]
            ]
    }





