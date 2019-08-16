module PageNotFound exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Layouts.DefaultLayout as DefaultLayout

type alias Model =
    {
        title: String
    }


type Msg
    = NotFoundMsg


init : Model
init = { title = "Home" }



-- VIEW
view : Model -> DefaultLayout.Details msg
view model =
    {
        title = "PAGE NOT FOUND!!"
        , attrs = []
        , kids = [
                div[]
                [ h1[][ text "PAGE NOT FOUND!!" ]
                ]
        ]
    }
