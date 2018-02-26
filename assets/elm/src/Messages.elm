module Messages exposing (..)

import Json.Encode
import Navigation
import Routing exposing (Route)


type Msg
    = FetchContactListSuccess Json.Encode.Value
    | FetchContactListError Json.Encode.Value
    | Paginate Int
    | HandleSearchInput String
    | HandleFormSubmit
    | ResetSearch
    | UrlChange Navigation.Location
    | NavigateTo Route
    | FetchContactSuccess Json.Encode.Value
    | FetchContactError Json.Encode.Value
