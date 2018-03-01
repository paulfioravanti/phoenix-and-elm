module Messages exposing (Msg(..))

import GraphQL.Client.Http
import Http
import Model exposing (ContactList, Contact)
import Navigation
import Routing exposing (Route)


type Msg
    = FetchContact (Result GraphQL.Client.Http.Error Contact)
    | FetchContactList (Result GraphQL.Client.Http.Error ContactList)
    | NavigateTo Route
    | Paginate Int
    | ResetSearch
    | SearchContacts
    | UpdateSearchQuery String
    | UrlChange Navigation.Location
