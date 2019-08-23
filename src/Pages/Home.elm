module Pages.Home exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Components.UI.Container as Container
import Components.UI.Row as Row
import Components.UI.Col as Col
import Components.UI.Form.Text as TextInput

type alias Model =
    { currentEntry : Entry
    , error : Error
    , titleInput : TextInput.Model 
    }

type Error
    = Title String
    | Content String
    | Both { content : String, title : String }
    | NoErrors

type alias Entry =
    { title : String
    , content: String
    , status : EntryStatus 
    }

type EntryStatus 
    = InProgress 
    | Complete
    | Blocked
    | Invalid


type Msg
    = TitleInputMsg TextInput.Msg


init : ( Model, Cmd Msg )
init = 
    (
        { currentEntry = newEntry
        , error = NoErrors
        , titleInput = TextInput.init 
        }
    , Cmd.none
    )

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TitleInputMsg subMsg ->
            let
                ( subModel, subCmd, extMsg ) =
                    TextInput.update subMsg model.titleInput

                updateFn =
                    case extMsg of
                        TextInput.ValueUpdated (Just title) ->
                            updateCurrentEntryTitle title

                        TextInput.ValueUpdated Nothing ->
                            updateCurrentEntryTitle "" << updateCurrentEntryStatus Invalid
            in
            ( { model
                | titleInput = subModel
                , currentEntry = updateFn model.currentEntry
              }
            , Cmd.map TitleInputMsg subCmd
            )

view : Model -> { title: String, attrs: List(Attribute Msg), kids: List(Html Msg) }
view model =
    let
        ( titleErrorMsg, contentErrorMsg ) =
            ( getTitleErrorMessage model.error
            , getContentErrorMessage model.error
            )
    in
    { title = "hhhhh" 
    , attrs = []
    , kids = [    
        Container.view [] 
        [
            Row.view []
            [ 
                Col.view (Col.Config Col.MD 6 ( Just (Col.Offset Col.MD 3)) [ class "ta-center" ] )
                [ h1[class "thin mt-7", style "fontSize" "3em", style "color" "#b5b0b0" ][ text "TODO" ]
                , 
                    div [class "text-align-sm-l mt-5"]
                    [ p[] [ text "Add new task" ]
                    , Html.map TitleInputMsg 
                        <| TextInput.view model.titleInput
                            { placeholder = "Enter a value"
                            , validationRules =
                                { lengthRules = TextInput.EmptyAllowed
                                , valueRules = TextInput.Alphanumeric
                                , textFormat = Just TextInput.Lowercase
                                }
                            }
                    ]
                ]
            ]
        ]

        ]
    }



newEntry : Entry
newEntry = Entry "" "" InProgress

updateCurrentEntryTitle : String -> Entry -> Entry
updateCurrentEntryTitle str entry = 
    { entry | title = str }

updateCurrentEntryContent : String -> Entry -> Entry
updateCurrentEntryContent str entry = 
    { entry | content = str }


updateCurrentEntryStatus : EntryStatus -> Entry -> Entry
updateCurrentEntryStatus status entry =
    { entry | status = status }


updateEntries : Entry -> List Entry -> List Entry
updateEntries entry entries = 
    List.append (List.singleton entry) entries



getTitleErrorMessage : Error -> Maybe String
getTitleErrorMessage error =
    case error of
        Both { title } ->
            Just title
        Title err ->
            Just err
        _ ->
            Nothing


getContentErrorMessage : Error -> Maybe String
getContentErrorMessage error =
    case error of
        Both { content } ->
            Just content
        Content err ->
            Just err
        _ ->
            Nothing

