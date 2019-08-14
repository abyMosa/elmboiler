module Routes exposing ( Route(..) , matchRoute )

import Url.Parser as Url exposing ((</>), (<?>))
import Url.Parser.Query as Query

type Route
    = Home
    | About


matchRoute : Url.Parser (Route -> a) a
matchRoute =
    Url.oneOf
        [ Url.map About <| Url.s "about"
        , Url.map Home <| Url.top
        ]