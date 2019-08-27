module Pages.PageNotFound exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

type alias Model =
    { }

type Msg
    = NotFoundMsg


init : Model
init = {}


view : Model -> List(Html Msg)
view model =
    [ 
        div[class "df f-jc-center f-aa-center"]
        [ h1[ class "thin mt-7", style "fontSize" "3em", style "color" "#b5b0b0" ]
            [ text "Page Not Found!!!" 
            ]
        ]
    ]
