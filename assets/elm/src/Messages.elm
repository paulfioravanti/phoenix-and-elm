module Messages exposing (Msg(..))

import Contact.Messages exposing (ContactMsg)
import ContactList.Model exposing (ContactList)
import Http
import Navigation
import Routing exposing (Route)


type Msg
    = ContactMsg ContactMsg
    | FetchContactList (Result Http.Error ContactList)
    | NavigateTo Route
    | Paginate Int
    | ResetSearch
    | SearchContacts
    | UpdateSearchQuery String
    | UrlChange Navigation.Location
