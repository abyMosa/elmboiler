module Content exposing (..)

import Browser
import Html exposing (Html, text, div, h1, img, b, a, ul, li)
import Html.Attributes exposing (src, class, href)

import Home as Home
import About as About
import PageNotFound as NotFound

import Routes exposing (..)

import Layouts.DefaultLayout as DefaultLayout exposing (..)
import Layouts.EmptyLayout as EmptyLayout exposing (..)


type alias Model = 
    { homeModel : Home.Model
    -- , defaultLayoutModel: DefaultLayout.Model
    -- , emptyLayoutModel: EmptyLayout.Model   
    }

type Msg 
    = HomeMsg Home.Msg
    -- | NotFoundMsg NotFound.Msg
    -- | DefaultLayoutMsg DefaultLayout.Msg
    -- | EmptyLayoutMsg EmptyLayout.Msg


init : (Model, Cmd Msg)
init = 
    let
        ( homeModel, homeCmd ) =
            Home.init    
    in
    
    ({ homeModel = homeModel }, Cmd.none)
    -- (   { defaultLayoutModel = DefaultLayout.init
    --     , emptyLayoutModel = EmptyLayout.init
    --     }
    -- , Cmd.none
    -- )

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        HomeMsg homeMsg -> 
            let            
                ( subModel, subCmd ) =
                    Home.update homeMsg model.homeModel  
            in        
            ( { model | homeModel = subModel }, Cmd.map HomeMsg subCmd )



-- view : Routes.Route -> Model -> Html Msg
view : Routes.Route -> Model -> Browser.Document Msg
view route model =
    -- let
    --     viewLayout toMsg layoutView layoutModel =
    --         Html.map toMsg <| layoutView route layoutModel
    -- in
    case route of
        -- here goes other routes that uses different layout, by default every route will use DefaultLayout 
        -- Routes.Home -> 
        --     viewLayout EmptyLayoutMsg EmptyLayout.view model.emptyLayoutModel
        -- _ -> 
        --     viewLayout DefaultLayoutMsg DefaultLayout.view model.defaultLayoutModel
        
        
        -- NotFound ->
        --     EmptyLayout.view PageNotFound (NotFound.view notfound)
        Home ->
            EmptyLayout.view HomeMsg (Home.view model.homeModel)
        -- About -> 
        --     DefaultLayout.view PageAbout (About.view about)




