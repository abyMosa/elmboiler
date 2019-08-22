module Content exposing (..)

import Browser
import Html exposing (Html, Attribute, text, div, h1, img, b, a, ul, li)
import Html.Attributes exposing (src, class, href)

import Containers.Home as Home
import Containers.About as About
import Containers.PageNotFound as NotFound

import Routes exposing (..)

import HOC.DefaultLayout as DefaultLayout exposing (..)
import HOC.EmptyLayout as EmptyLayout exposing (..)


type alias Model = 
    { homeModel : Home.Model 
    , aboutModel : About.Model
    , notFoundModel : NotFound.Model
    }

type Msg 
    = HomeMsg Home.Msg
    | AboutMsg About.Msg
    | NotFoundMsg NotFound.Msg


init : (Model, Cmd Msg)
init = 
    let
        (homeModel, homeCmd) =
                        Home.init    

        (aboutModel, aboutCmd) =
                        About.init    
        notFoundModel =
                    NotFound.init    
    in
    ( { homeModel = homeModel
      , aboutModel = aboutModel 
      , notFoundModel = notFoundModel 
      }
      , Cmd.none 
    )

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        HomeMsg homeMsg -> 
            let            
                ( subModel, subCmd ) =
                    Home.update homeMsg model.homeModel  
            in        
            ( { model | homeModel = subModel }, Cmd.map HomeMsg subCmd )
        
        AboutMsg aboutMsg -> 
            let            
                ( subModel, subCmd ) =
                    About.update aboutMsg model.aboutModel  
            in        
            ( { model | aboutModel = subModel }, Cmd.map AboutMsg subCmd )
        
        NotFoundMsg notFoundMsg -> 
            ( model, Cmd.none )
        

view :Routes.Route -> Model -> { title: String, body: List(Html Msg) }
view route model =
    let
        {title, body} =
            case route of
                Home ->
                    EmptyLayout.view HomeMsg (Home.view model.homeModel)
                About -> 
                    DefaultLayout.view AboutMsg (About.view model.aboutModel)
                NotFound -> 
                    EmptyLayout.view NotFoundMsg (NotFound.view model.notFoundModel)
    in
    { title = title
    , body = body
    }