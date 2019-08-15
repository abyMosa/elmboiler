module Main exposing (..)

import Browser
import Html exposing (Html, text, div, h1, img, b, a, ul, li)
import Html.Attributes exposing (src, class, href)
import Json.Decode as Decode exposing (Value)

import Browser.Navigation as Navigation
import Url
import Url.Parser as Parser exposing (Parser, (</>), custom, fragment, map, oneOf, s, top)

import Url.Parser as Url exposing ((</>), (<?>))
import Url.Parser.Query as Query


import Home as Home
import About as About
import Layouts.MainLayout as MainLayout
import PageNotFound as NotFound

---- MODEL ----

type alias Model =
    { url : Url.Url
    , key : Navigation.Key
    , route : Route
    }

type Route
    = Home
    | About

init : () -> Url.Url -> Navigation.Key -> ( Model, Cmd Msg )
init _ url key =
    ( 
        { url = url
        , key = key 
        , route = Home
        }, 
        Cmd.none 
    )



---- UPDATE ----


type Msg
  = PageNotFound NotFound.Msg
  | PageHome Home.Msg
  | PageAbout About.Msg
  | UrlRequested Browser.UrlRequest
  | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    UrlRequested urlRequest ->
      case urlRequest of
        Browser.Internal url ->
          ( model, Navigation.pushUrl model.key (Url.toString url) )

        Browser.External href ->
          ( model, Navigation.load href )

    UrlChanged url ->
            ( { model | url = url }
            , Cmd.none
            )

    PageNotFound notFoundMsg -> 
        ( model, Cmd.none)
    
    PageHome homeMsg -> 
        ( model, Cmd.none)
    
    PageAbout aboutMsg -> 
        ( model, Cmd.none)


---- VIEW ----

view : Model -> Browser.Document Msg
view model =
    { title = "Cockpit"
    , body = body model
    }



body : Model -> List (Html Msg)
body model =
    [ info
    , navigation
    , content model
    ]



content : Model -> Html Msg
content model =
    div []
        -- [ case Url.parse Route.parser model.url of
        [ case Url.parse matchRoute model.url of
            Just path ->
                matchedRoute path

            Nothing ->
                NotFound.view |> Html.map PageNotFound
        ]

matchedRoute : Route -> Html Msg
matchedRoute path =
    case path of
        Home ->
            Home.view |> Html.map PageHome

        About ->
            About.view |> Html.map PageAbout


navigation : Html Msg
navigation =
    ul []
        [ li [] [ createLink "" ]
        , li [] [ createLink "about" ]
        ]

createLink : String -> Html Msg
createLink path =
    a [ href ("/" ++ path) ] 
    [ 
        if path == "" then 
            text "Home"
        else
            text path
    ]


info : Html Msg
info =
    div [] [ text "Header" ]



matchRoute : Url.Parser (Route -> a) a
matchRoute =
    Url.oneOf
        [ Url.map About <| Url.s "about"
        , Url.map Home <| Url.top
        ]





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
        


-- HElPERS
-- viewLink : String -> Html msg
-- viewLink path =
--   li [] [ a [ href path ] [ text path ] ]

