module Messages exposing (Msg(..))

import Contact.Model exposing (Contact)
import Http
import Model exposing (ContactList, Query)
import Navigation
import Routing exposing (Route)


type Msg
    = FetchContact (Result Http.Error Contact)
    | FetchContactList (Result Http.Error ContactList)
    | NavigateTo Route
    | Paginate Int
    | ResetSearch
    | SearchContacts
    | UpdateSearchQuery Query
    | UrlChange Navigation.Location
