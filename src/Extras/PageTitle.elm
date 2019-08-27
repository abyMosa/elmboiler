module Extras.PageTitle exposing (get)

import Routes exposing (Route(..))

-- type Language
--     = English
--     | Greek

-- get2 : Language -> (Route -> String)
-- get2 language =
--     english


-- get : Language -> Route -> String
-- get language =
--     case language of
--         English ->
--             english
--         Greek ->
--             greek

get : Route -> String
get =
    english

english : Route -> String
english route =
    case route of
        Home -> "Home"
        About -> "About"
        Todo -> "Todo"
        NotFound -> "Not Found"

greek : Route -> String
greek route =
    case route of
        Home -> "Greek Home"
        About -> "Greek About"
        Todo -> "Greek Todo"
        NotFound -> "Greek Not Found"