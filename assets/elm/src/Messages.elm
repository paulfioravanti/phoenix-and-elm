module Messages exposing (Msg(..))

import Json.Encode
import Navigation
import Routing exposing (Route)


type Msg
    = FetchContactSuccess Json.Encode.Value
    | FetchContactError Json.Encode.Value
    | FetchContactListSuccess Json.Encode.Value
    | FetchContactListError Json.Encode.Value
    | NavigateTo Route
    | Paginate Int
    | ResetSearch
    | SearchContacts
    | UpdateSearchQuery String
    | UrlChange Navigation.Location
