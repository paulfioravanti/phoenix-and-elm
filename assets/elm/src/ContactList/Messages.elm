module ContactList.Messages exposing (Msg(..))

import ContactList.Model exposing (ContactList)
import Http


type Msg
    = FetchContactList (Result Http.Error ContactList)
    | SearchContacts
    | Paginate Int
