module Home exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Layouts.DefaultLayout as DefaultLayout
import Components.Form.Text as TextInput


type alias Model =
    { currentEntry: Entry
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

init : Model
init = 
        { currentEntry = newEntry
        , error = NoErrors
        , titleInput = TextInput.init 
        }

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
                            let
                                _ = 
                                    Debug.log "title" title
                            in                            
                            updateCurrentEntryTitle title

                        TextInput.ValueUpdated Nothing ->
                            let
                                _ = 
                                    Debug.log "nothing" 
                            in
                            
                            updateCurrentEntryTitle "" << updateCurrentEntryStatus Invalid
            in
            ( { model
                | titleInput = subModel
                , currentEntry = updateFn model.currentEntry
              }
            , Cmd.map TitleInputMsg subCmd
            )




-- VIEW
view : Model -> DefaultLayout.Details Msg
view model =
    { title = "Home Page | Hello World"
    , attrs = []
    , kids = [
            div[]
            [ h1[][ text "Home page, Hello World" ]
            , p[][ text "Tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet." ]
            , Html.map TitleInputMsg 
                    <| TextInput.view model.titleInput
                        { placeholder = "Enter a value"
                        , validationRules =
                            { lengthRules = TextInput.EmptyAllowed
                            , valueRules = TextInput.AlphabeticOnly
                            , textFormat = Just TextInput.Lowercase
                            }
                        }
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
