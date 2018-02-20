module Messages exposing (Msg(..))

import Http
import Model exposing (ContactList, Contact)
import Navigation
import Routing exposing (Route)


type Msg
    = FetchContactResult (Result Http.Error Contact)
    | FetchResult (Result Http.Error ContactList)
    | HandleFormSubmit
    | HandleSearchInput String
    | NavigateTo Route
    | Paginate Int
    | ResetSearch
    | UrlChange Navigation.Location
