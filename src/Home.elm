module Home exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
-- import Layouts.DefaultLayout as DefaultLayout
-- import Layouts.EmptyLayout as EmptyLayout

import Components.UI.Container as Container
import Components.UI.Row as Row
import Components.UI.Col as Col
import Components.UI.Form.Text as TextInput

type alias Model =
    { title : String
    , titleInput : TextInput.Model 
    }

type Msg
    = NoOp
    | TitleInputMsg TextInput.Msg


init : Model
init = 
    { title = "Home"
    , titleInput = TextInput.init 
    }

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none)


view : Model -> Html Msg
view model =
    Container.view (Container.Config [ class "full-vh" ] 
    [
        Row.view (Row.Config [ class " full-vh" ]
        [ 
            Col.view (Col.Config Col.MD 6 (Col.Offset Col.MD 3) [ class "ta-center" ]
            [ h1[class "thin mt-7", style "fontSize" "3em", style "color" "#b5b0b0" ][ text "TODO" ]
            , 
                div [class "text-align-sm-l mt-5"]
                [ p[] [ text "Add new task" ]
                        

                ]

            ])
        ])
    ])
