module ContactList.Messages exposing (ContactListMsg(..))

import ContactList.Model exposing (ContactList)
import GraphQL.Client.Http as Http


type ContactListMsg
    = FetchContactList (Result Http.Error ContactList)
    | Paginate Int
    | ResetSearch
    | SearchContacts
