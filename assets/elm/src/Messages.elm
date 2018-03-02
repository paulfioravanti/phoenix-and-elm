module Messages exposing (Msg(..))

import Contact.Messages exposing (ContactMsg)
import ContactList.Messages exposing (ContactListMsg)
import Navigation
import Routing exposing (Route)


type Msg
    = ContactMsg ContactMsg
    | ContactListMsg ContactListMsg
    | NavigateTo Route
    | UpdateSearchQuery String
    | UrlChange Navigation.Location
