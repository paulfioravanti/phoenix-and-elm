module ContactList.Messages exposing (ContactListMsg(..))

import ContactList.Model exposing (ContactList)
import Http


type ContactListMsg
    = FetchContactList (Result Http.Error ContactList)
    | Paginate Int
    | ResetSearch
    | SearchContacts
