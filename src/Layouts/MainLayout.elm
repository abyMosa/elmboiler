module Layouts.MainLayout exposing (..)


import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Decode as D

type alias Details msg =
    { title : String
    , attrs : List (Attribute msg)
    , kids : List (Html msg)
    }



-- VIEW

view : (a -> msg) -> Details a -> Browser.Document msg
view toMsg details =
    { title =
        details.title
    , body =
        [ viewHeader 
        , Html.map toMsg <|
            div (class "center" :: details.attrs) details.kids
        , viewFooter
        ]
    }

---- VIEW ----
-- view : Model -> Browser.Document Msg
-- view model =
--     { title = "TODO APP"
--     , body =
--         [ 
--         -- text "The current URL is: "
--         -- , b [] [ text (Url.toString model.url) ]
--         -- , ul []
--         --   [ viewLink "/"
--         --   , viewLink "/profile"
--         --   , viewLink "/reviews/the-century-of-the-self"
--         --   , viewLink "/reviews/public-opinion"
--         --   , viewLink "/reviews/shah-of-shahs"
--         --   ]
--         -- , div [ class "home-wrapper" ]
--         --     [ img [ src "/logo.svg" ] []
--         --     , h1 [] [ text "Your Elm App is working!" ]
--         --     ]
--         ]
--     }



-- VIEW HEADER
viewHeader : Html msg
viewHeader =
  div
    [ style "background-color" "#eeeeee"
    ]
    [ div [class "center"]
        [ h1 [ class "header" ] []
        ]
    ]


viewFooter : Html msg
viewFooter =
  div [class "footer"]
    [ text "All code for this site is open source and written in Elm. "
    , a [ class "grey-link", href "https://github.com/elm/package.elm-lang.org/" ] [ text "Check it out" ]
    , text "! — © 2012-present Evan Czaplicki"
    ]


