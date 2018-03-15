module Messages exposing (Msg(..))

import Contact.Messages
import ContactList.Messages exposing (ContactListMsg)
import Navigation
import Routing exposing (Route)


type Msg
    = ContactMsg Contact.Messages.Msg
    | ContactListMsg ContactListMsg
    | NavigateTo Route
    | UpdateSearchQuery String
    | UrlChange Navigation.Location
