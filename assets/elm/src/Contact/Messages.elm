module Contact.Messages exposing (ContactMsg(..))

import Json.Encode


type ContactMsg
    = FetchContactSuccess Json.Encode.Value
    | FetchContactError Json.Encode.Value
