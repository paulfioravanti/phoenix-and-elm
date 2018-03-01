module ContactList.Messages exposing (ContactListMsg(..))

import GraphQL.Client.Http
import Model exposing (ContactList)


type ContactListMsg
    = FetchContactList (Result GraphQL.Client.Http.Error ContactList)
    | Paginate Int
    | ResetSearch
    | SearchContacts
