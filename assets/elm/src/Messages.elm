module Messages exposing (Msg(..))

import Contact.Messages
import ContactList.Messages
import Navigation
import Routing.Messages


type Msg
    = ContactMsg Contact.Messages.Msg
    | ContactListMsg ContactList.Messages.Msg
    | UpdateSearchQuery String
    | UrlChange Navigation.Location
    | ResetSearch
    | RoutingMsg Routing.Messages.Msg
