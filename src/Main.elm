module Main exposing (..)

import Browser
import Html exposing (Html, text, div, h1, img, b, a, ul, li)
import Html.Attributes exposing (src, class, href)
import Browser.Navigation as Navigation
import Url
import Routes
import Content exposing (..)
import Extras.PageTitle as PageTitle

---- MODEL ----
type alias Model =
    { route: Routes.Route
    , key : Navigation.Key
    , contentModel : Content.Model
    }

init : () -> Url.Url -> Navigation.Key -> ( Model, Cmd Msg )
init _ url key =
    let
        ( contentModel, contentCmd ) = Content.init
    in
    ( 
      { route = Routes.matchedRoute url
      , key = key
      , contentModel = contentModel
      }
    , Cmd.none
    )

---- UPDATE ----
type Msg
    = UrlRequested Browser.UrlRequest
    | UrlChanged Url.Url
    | ContentMsg Content.Msg

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
        
        ContentMsg subMsg -> 
            let
                ( subModel, subCmd ) =
                    Content.update subMsg model.contentModel
            in
            ( { model | contentModel = subModel }, Cmd.none)
    

---- VIEW ----
view : Model -> Browser.Document Msg
view model =
    { title = PageTitle.get model.route ++ " | Elm Boiler"
    , body = List.map (Html.map ContentMsg) <| Content.view model.route model.contentModel
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
