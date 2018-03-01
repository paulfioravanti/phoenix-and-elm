module Messages exposing (Msg(..))

import Contact.Messages exposing (ContactMsg)
import GraphQL.Client.Http
import Model exposing (ContactList, Contact)
import Navigation
import Routing exposing (Route)


type Msg
    = ContactMsg ContactMsg
    | FetchContactList (Result GraphQL.Client.Http.Error ContactList)
    | NavigateTo Route
    | Paginate Int
    | ResetSearch
    | SearchContacts
    | UpdateSearchQuery String
    | UrlChange Navigation.Location
