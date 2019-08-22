module Content exposing (..)

import Browser
import Html exposing (Html, Attribute, text, div, h1, img, b, a, ul, li)
import Html.Attributes exposing (src, class, href)

import Home as Home
import About as About
import PageNotFound as NotFound

import Routes exposing (..)

import Layouts.DefaultLayout as DefaultLayout exposing (..)
import Layouts.EmptyLayout as EmptyLayout exposing (..)


type alias Model = 
    { homeModel : Home.Model 
    }

type Msg 
    = HomeMsg Home.Msg
    -- | NotFoundMsg NotFound.Msg


init : (Model, Cmd Msg)
init = 
    let
        ( homeModel, homeCmd ) =
            Home.init    
    in
    ({ homeModel = homeModel }, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        HomeMsg homeMsg -> 
            let            
                ( subModel, subCmd ) =
                    Home.update homeMsg model.homeModel  
            in        
            ( { model | homeModel = subModel }, Cmd.map HomeMsg subCmd )


view :Routes.Route -> Model -> { title: String, body: Html Msg }
-- view : Routes.Route -> Model -> Browser.Document Msg
view route model =
    let
        {title, body} =
            case route of
                Home ->
                    EmptyLayout.view HomeMsg (Home.view model.homeModel)                     
                _ ->
                    {title = "about", body = div[][text "rwg"] }
    in
    { title = title
    , body = body
    }