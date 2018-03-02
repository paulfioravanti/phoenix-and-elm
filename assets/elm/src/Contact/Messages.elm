module Contact.Messages exposing (ContactMsg(..))

import Json.Encode as Encode


type ContactMsg
    = FetchContactSuccess Encode.Value
    | FetchContactError Encode.Value
