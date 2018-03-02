module ContactList.Messages exposing (ContactListMsg(..))

import Json.Encode


type ContactListMsg
    = FetchContactListSuccess Json.Encode.Value
    | FetchContactListError Json.Encode.Value
    | Paginate Int
    | ResetSearch
    | SearchContacts
