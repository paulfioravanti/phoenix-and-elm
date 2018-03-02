module Messages exposing (Msg(..))

import Contact.Model exposing (Contact)
import ContactList.Model exposing (ContactList)
import Http
import Navigation
import Routing exposing (Route)


type Msg
    = FetchContact (Result Http.Error Contact)
    | FetchContactList (Result Http.Error ContactList)
    | NavigateTo Route
    | Paginate Int
    | ResetSearch
    | SearchContacts
    | UpdateSearchQuery String
    | UrlChange Navigation.Location
