module Routes exposing ( Route(..) , matchRoute, matchedRoute )

import Html exposing (Html, text, div, h1, img, b, a, ul, li)
import Html.Attributes exposing (src, class, href)

import Browser.Navigation as Navigation
import Url
import Url.Parser as Url exposing (Parser, (</>), custom, fragment, map, oneOf, s, top)
import Url.Parser.Query as Query

type Route
    = Home 
    | About 
    | Todo
    | NotFound



-- HELPERS
matchRoute : Url.Parser (Route -> a) a
matchRoute =   
    Url.oneOf
        [ Url.map Todo <| Url.s "todo"
        , Url.map About <| Url.s "about"
        , Url.map Home <| Url.top
        ]


matchedRoute : Url.Url -> Route
matchedRoute url =
    case Url.parse matchRoute url of
        Just route -> 
            route

        Nothing ->
            NotFound