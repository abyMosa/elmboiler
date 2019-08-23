module Components.UI.NavigationItems exposing (..)
 
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

type alias Item =
    { title: String, link: String }

view : List(Attribute msg) -> List Item -> Html msg
view attr items =
    ul (class "navigationItems" :: attr) (renderListItems items)


renderListItems : List Item ->  List( Html msg )
renderListItems items =
        List.map (\item -> li [][ a [href item.link ][text item.title] ] ) items

