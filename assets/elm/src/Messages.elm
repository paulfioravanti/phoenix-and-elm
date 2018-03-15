module Messages exposing (Msg(..))

import Contact.Messages
import ContactList.Messages
import Navigation
import Routing exposing (Route)


type Msg
    = ContactMsg Contact.Messages.Msg
    | ContactListMsg ContactList.Messages.Msg
    | NavigateTo Route
    | UpdateSearchQuery String
    | UrlChange Navigation.Location
    | ResetSearch
