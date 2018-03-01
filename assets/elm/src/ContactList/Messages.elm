module ContactList.Messages exposing (ContactListMsg(..))

import GraphQL.Client.Http as Http
import Model exposing (ContactList)


type ContactListMsg
    = FetchContactList (Result Http.Error ContactList)
    | Paginate Int
    | ResetSearch
    | SearchContacts
