module Layouts.EmptyLayout exposing (..)


import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Decode as D
import Routes

import Home as Home
import PageNotFound as NotFound

type alias Model =
    { homeModel : Home.Model
    , notFoundModel: NotFound.Model        
    }

type Msg 
    = HomeMsg Home.Msg
    | NotFoundMsg NotFound.Msg



init : Model
init =
    let
        ( homeModel, subCmd ) = Home.init          
    in
        
    { homeModel = homeModel
    , notFoundModel = NotFound.init
    }

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HomeMsg home ->
            
        
            



-- VIEW 
view : Routes.Route -> Model -> Html Msg
view route model =
    let
        viewPage toMsg pageView pageModel =
            Html.map toMsg <| pageView pageModel
        
        kids = 
            case route of
                Routes.Home ->
                    viewPage HomeMsg Home.view model.homeModel
                Routes.NotFound ->
                    viewPage NotFoundMsg NotFound.view model.notFoundModel
                
                _ -> 
                    div[][text ""]
                    
    in
    div [ class "center app emptylayout" ]
    [ kids
    ]
