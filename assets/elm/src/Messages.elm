module Messages exposing (Msg(..))

import GraphQL.Client.Http
import Http
import Model exposing (ContactList, Contact, PageNumber)
import Navigation
import Routing exposing (Route)


type Msg
    = FetchContact (Result Http.Error Contact)
    | FetchContactRequest (Result GraphQL.Client.Http.Error Contact)
    | FetchContactList (Result Http.Error ContactList)
    | NavigateTo Route
    | Paginate PageNumber
    | ResetSearch
    | SearchContacts
    | UpdateSearchQuery String
    | UrlChange Navigation.Location
