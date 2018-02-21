module Messages exposing (Msg(..))

import Http
import Model exposing (ContactList, Contact)
import Navigation
import Routing exposing (Route)


type Msg
    = FetchContact (Result Http.Error Contact)
    | FetchContactList (Result Http.Error ContactList)
    | HandleFormSubmit
    | HandleSearchInput String
    | NavigateTo Route
    | Paginate Int
    | ResetSearch
    | UrlChange Navigation.Location
