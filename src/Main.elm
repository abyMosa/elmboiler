module Main exposing (..)

import Browser
import Html exposing (Html, text, div, h1, img, b, a, ul, li)
import Html.Attributes exposing (src, class, href)
import Json.Decode as Decode exposing (Value)
-- import Route exposing (Route)

import Browser.Navigation as Navigation
import Url
import Url.Parser as Parser exposing (Parser, (</>), custom, fragment, map, oneOf, s, top)
import Routes exposing (Route(..), matchRoute)
import Url.Parser as U

import Home as Home
import Layouts.MainLayout as MainLayout


---- MODEL ----


type alias Model =
    { url : Url.Url
    , navigationKey : Navigation.Key
    , currentRoute : Route
    }

init : () -> Url.Url -> Navigation.Key -> ( Model, Cmd Msg )
init _ url key =
    ( 
        { url = url
        , navigationKey = key 
        , currentRoute = Home
        }, 
        Cmd.none 
    )



---- UPDATE ----


type Msg
  = UrlRequested Browser.UrlRequest
  | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    UrlRequested urlRequest ->
      case urlRequest of
        Browser.Internal url ->
          ( model, Navigation.pushUrl model.navigationKey (Url.toString url) )

        Browser.External href ->
          ( model, Navigation.load href )

    UrlChanged url ->
        let 
            maybeRoute =
                U.parse Routes.matchRoute url
        in
            ( { model | currentRoute = Maybe.withDefault model.currentRoute maybeRoute }, Cmd.none )



---- VIEW ----
view : Model -> Browser.Document Msg
view model =
    { title = "TODO APP"
    , body =
        [ 
        text "The current URL is: "
        , b [] [ text (Url.toString model.url) ]
        , ul []
          [ viewLink "/"
          , viewLink "/about"
          ]
        , div [ class "home-wrapper" ]
            [ img [ src "/logo.svg" ] []
            , h1 [] [ text "Your Elm App is working!" ]
            ]
        ]
    }



subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = UrlRequested
        , onUrlChange = UrlChanged
        }
        


-- HElPERS
viewLink : String -> Html msg
viewLink path =
  li [] [ a [ href path ] [ text path ] ]
