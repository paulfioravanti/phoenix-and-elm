module Messages exposing (Msg(..))

import Contact.Messages exposing (ContactMsg)
import ContactList.Messages exposing (ContactListMsg)
import GraphQL.Client.Http
import Model exposing (ContactList, Contact)
import Navigation
import Routing exposing (Route)


type Msg
    = ContactMsg ContactMsg
    | ContactListMsg ContactListMsg
    | NavigateTo Route
    | Paginate Int
    | ResetSearch
    | SearchContacts
    | UpdateSearchQuery String
    | UrlChange Navigation.Location
