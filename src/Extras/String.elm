module Extras.String exposing
    ( onlyAlphabetic
    , onlyDigits
    , onlyLowercase
    , onlyUppercase
    , isTitlecase
    )


onlyAlphabetic : String -> Bool
onlyAlphabetic val =
    -- String.all (\char -> not (Char.isDigit char)) val
    String.all (not << Char.isDigit) val

onlyDigits : String -> Bool
onlyDigits val =
    String.all (Char.isDigit) val


onlyLowercase : String -> Bool
onlyLowercase val =
    String.toLower val == val 

onlyUppercase : String -> Bool
onlyUppercase val =
    String.toUpper val == val


isTitlecase : String -> Bool
isTitlecase val =
    let
        firstLetter = 
            String.left 1 val 

        rest =
            String.dropLeft 1 val
    in
    String.toUpper firstLetter == firstLetter
        && String.toLower rest == rest