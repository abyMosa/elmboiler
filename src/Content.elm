module Content exposing (..)

import Browser
import Html exposing (Html, Attribute, text, div, h1, img, b, a, ul, li)
import Html.Attributes exposing (src, class, href)

import Pages.Home as Home
import Pages.About as About
import Pages.Todo as Todo
import Pages.PageNotFound as NotFound

import Routes exposing (..)

import HOC.DefaultLayout as DefaultLayout exposing (..)
import HOC.EmptyLayout as EmptyLayout exposing (..)
import HOC.SidebarLayout as SidebarLayout exposing (..)


type alias Model = 
    { homeModel : Home.Model 
    , aboutModel : About.Model
    , todoModel : Todo.Model
    , notFoundModel : NotFound.Model
    }

type Msg 
    = HomeMsg Home.Msg
    | AboutMsg About.Msg
    | TodoMsg Todo.Msg
    | NotFoundMsg NotFound.Msg


init : (Model, Cmd Msg)
init = 
    let
        (homeModel, homeCmd) = Home.init    
        (aboutModel, aboutCmd) = About.init    
        (todoModel, tasksCmd) = Todo.init    
        notFoundModel = NotFound.init    
    in
    ( { homeModel = homeModel
      , aboutModel = aboutModel 
      , todoModel = todoModel
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
        
        TodoMsg todoMsg -> 
            let            
                ( subModel, subCmd ) =
                    Todo.update todoMsg model.todoModel  
            in        
            ( { model | todoModel = subModel }, Cmd.map TodoMsg subCmd )
        
        NotFoundMsg notFoundMsg -> 
            ( model, Cmd.none )
        

view :Routes.Route -> Model -> List (Html Msg)
view route model =
     case route of
        Home ->
            DefaultLayout.view HomeMsg (Home.view model.homeModel)
        About -> 
            DefaultLayout.view AboutMsg (About.view model.aboutModel)
        Todo -> 
            SidebarLayout.view TodoMsg (Todo.view model.todoModel)
        NotFound -> 
            EmptyLayout.view NotFoundMsg (NotFound.view model.notFoundModel)