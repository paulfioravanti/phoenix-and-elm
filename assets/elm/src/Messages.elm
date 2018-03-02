module Messages exposing (Msg(..))

import Contact.Messages exposing (ContactMsg)
import Json.Encode
import Navigation
import Routing exposing (Route)


type Msg
    = ContactMsg ContactMsg
    | FetchContactListSuccess Json.Encode.Value
    | FetchContactListError Json.Encode.Value
    | NavigateTo Route
    | Paginate Int
    | ResetSearch
    | SearchContacts
    | UpdateSearchQuery String
    | UrlChange Navigation.Location
