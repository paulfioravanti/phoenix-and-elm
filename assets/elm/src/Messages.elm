module Messages exposing (Msg(..))

import Json.Encode
import Model exposing (PageNumber, Query)
import Navigation
import Routing exposing (Route)


type Msg
    = FetchContactSuccess Json.Encode.Value
    | FetchContactError Json.Encode.Value
    | FetchContactListSuccess Json.Encode.Value
    | FetchContactListError Json.Encode.Value
    | NavigateTo Route
    | Paginate PageNumber
    | ResetSearch
    | SearchContacts
    | UpdateSearchQuery Query
    | UrlChange Navigation.Location
