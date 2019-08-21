module Main exposing (..)

import Browser
import Html exposing (Html, text, div, h1, img, b, a, ul, li)
import Html.Attributes exposing (src, class, href)

import Browser.Navigation as Navigation
import Url
import Routes

import Home as Home
import About as About
import PageNotFound as NotFound
import Layouts.DefaultLayout as DefaultLayout exposing (..)
import Layouts.EmptyLayout as EmptyLayout exposing (..)


---- MODEL ----
type alias Model =
    { title : String
    , route: Routes.Route
    , key : Navigation.Key
    , defaultLayoutModel: DefaultLayout.Model
    , emptyLayoutModel: EmptyLayout.Model
    }

init : () -> Url.Url -> Navigation.Key -> ( Model, Cmd Msg )
init _ url key =
    let
        title = getTitleFromRoute url
    in
    ( 
      { title = title
      , route = Routes.matchedRoute url
      , key = key
      , defaultLayoutModel = DefaultLayout.init
      , emptyLayoutModel = EmptyLayout.init
      }
    , Cmd.none
    )

---- UPDATE ----
type Msg
    = UrlRequested Browser.UrlRequest
    | UrlChanged Url.Url
    | DefaultLayoutMsg DefaultLayout.Msg
    | EmptyLayoutMsg EmptyLayout.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    UrlRequested urlRequest ->
      case urlRequest of
        Browser.Internal url ->
          ( model
          , Navigation.pushUrl model.key (Url.toString url) 
          )

        Browser.External href ->
          ( model, Navigation.load href )

    UrlChanged url ->
            ( { model | route = Routes.matchedRoute url }
            , Cmd.none
            )
    DefaultLayoutMsg _ -> 
        (
            model, Cmd.none)
    
    EmptyLayoutMsg _ -> 
        (model, Cmd.none)


---- VIEW ----
view : Model -> Browser.Document Msg
view model =
    let
        viewLayout toMsg layoutView layoutModel =
            Html.map toMsg <| layoutView model.route layoutModel
    in
    { title =
        model.title
    , body = 
        [
            case model.route of
                -- here goes other routes that uses different layout, by default every route will use DefaultLayout 
                Routes.Home -> 
                    viewLayout EmptyLayoutMsg EmptyLayout.view model.emptyLayoutModel
                _ -> 
                    viewLayout DefaultLayoutMsg DefaultLayout.view model.defaultLayoutModel
        ]
    }


-- SUBSCRIPTION
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
        

getTitleFromRoute : Url.Url -> String
getTitleFromRoute url =
    case Routes.matchedRoute url of
        Routes.NotFound ->   
            "Not Found"
        Routes.Home ->
            "home"
        Routes.About ->
            "about"
