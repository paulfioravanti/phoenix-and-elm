module ContactList.Messages exposing (ContactListMsg(..))

import Json.Encode as Encode


type ContactListMsg
    = FetchContactListSuccess Encode.Value
    | FetchContactListError Encode.Value
    | Paginate Int
    | ResetSearch
    | SearchContacts
