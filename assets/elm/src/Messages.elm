module Messages exposing (Msg(..))

import Http
import Model exposing (ContactList, Contact, PageNumber, Query)
import Navigation
import Routing exposing (Route)


type Msg
    = FetchContact (Result Http.Error Contact)
    | FetchContactList (Result Http.Error ContactList)
    | NavigateTo Route
    | Paginate PageNumber
    | ResetSearch
    | SearchContacts
    | UpdateSearchQuery Query
    | UrlChange Navigation.Location
