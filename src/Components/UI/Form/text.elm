module Components.UI.Form.Text exposing
    ( Model
    , init
    , view
    , update
    , Msg(..)
    , LengthValidation(..)
    , ValueRules(..)
    , TextFormat(..)
    , ValidationRules
    , ExtMsg(..)
    )

import Html exposing (Html, div, text, input, Attribute, span)
import Html.Attributes exposing (class, type_, placeholder)
import Html.Events exposing (onInput)
import Extras.String as String
-- MODEL

type alias ValidationRules =
    { lengthRules : LengthValidation
    , valueRules : ValueRules
    , textFormat : Maybe TextFormat
    }
-- type ValidationRules
--     = ValidationRules LengthValidation ValueRules (Maybe TextFormat)

-- setValidationRules : LengthValidation -> ValueRules -> Maybe TextFormat -> ValidationRules
-- setValidationRules length value text =
--     ValidationRules length value text

type LengthValidation
    = EmptyAllowed
    | Constrained Int Int

type ValueRules
    = AlphabeticOnly
    | DigitsOnly
    | Alphanumeric

type TextFormat
    = Lowercase
    | Titlecase
    | Uppercase

type alias Config =
    { placeholder : String
    , validationRules : ValidationRules
    }

type alias Model =
    { value : String
    }

init : Model
init =
    { value = ""
    }


-- UPDATE 

type Msg
    = HandleInput ValidationRules String

type ExtMsg
    = ValueUpdated (Maybe String)

update : Msg -> Model -> ( Model, Cmd Msg, ExtMsg )
update msg model =
    case msg of 
        HandleInput rules val ->
            ( { model | value = val }
            , Cmd.none
            , if validate rules val == Nothing then
                ValueUpdated (Just val)

              else
                ValueUpdated Nothing
            ) 

-- VIEW
view : Model -> Config -> Html Msg
view model config =
    let
        errorMessage =
            validate config.validationRules model.value
    in
    div [ class "input-group" ]
        [ input [ type_ "text", onInput (HandleInput config.validationRules), placeholder config.placeholder ] []
        , case errorMessage of
            Just error ->
                span [ class "error" ] [ text error ]
            Nothing ->
                text "Success ☑"
        ]


-- HELPERS

-- validate : ValidationRules -> String -> Maybe String
-- validate { lengthRules, valueRules, textFormat } val =
--     case lengthRules of
--         EmptyAllowed ->
--             let
--                 errorMessage =
--                     valueValidation valueRules val
--             in
--             if errorMessage == Nothing then
--                 Maybe.andThen (\rules -> textFormatValidation rules val) textFormat
--             else
--                 errorMessage

--         Constrained min max ->
--             if String.length val >= min && String.length val <= max then
--                 let
--                     errorMessage =
--                         valueValidation valueRules val
--                 in
--                 if errorMessage == Nothing then
--                     Maybe.andThen (\rules -> textFormatValidation rules val) textFormat
--                 else
--                     errorMessage
--             else
--                 Just "String length is not matching the requirements"

validate : ValidationRules -> String -> Maybe String
validate { lengthRules, valueRules, textFormat } val =
    List.foldl
        (\error accum ->
            if accum == Nothing then
                error
            else
                accum
        )
        Nothing
        [ lengthValidation lengthRules val
        , valueValidation valueRules val
        , Maybe.andThen (\rule -> textFormatValidation rule val) textFormat
        ]


lengthValidation : LengthValidation -> String -> Maybe String
lengthValidation rules val =
    case rules of
        EmptyAllowed ->
            Nothing

        Constrained min max ->
            if String.length val >= min && String.length val <= max then
                Nothing
            else
                Just "String length is not matching the requirements"


valueValidation : ValueRules -> String -> Maybe String
valueValidation rules val =
    case rules of
        AlphabeticOnly ->
            if String.onlyAlphabetic val then
                Nothing
            else
                Just "I am sorry, title can only contain alphabetic characters"
        DigitsOnly ->
            if String.onlyDigits val then
                Nothing
            else
                Just "I am sorry, title can only contain digits"
        Alphanumeric ->
            Nothing


textFormatValidation : TextFormat -> String -> Maybe String
textFormatValidation rules val =
    case rules of
        Lowercase ->
            if String.onlyLowercase val then
                Nothing
            else
                Just "I am sorry, I can only accept lowercase letters"
        Titlecase ->
            if String.isTitlecase val then
                Nothing
            else
                Just "I am sorry, we need the first letter to be a capital one"
        Uppercase -> 
            if String.onlyUppercase val then
                Nothing
            else
                Just "I am sorry, I can only accept uppercase letters"