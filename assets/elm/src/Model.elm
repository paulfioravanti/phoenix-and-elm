module Model exposing (Model, initialModel)

import Contact.Model exposing (Contact)
import ContactList.Model exposing (ContactList)
import RemoteData exposing (RemoteData(NotRequested))
import Routing exposing (Route)


type alias Model =
    { contact : RemoteData String Contact
    , contactList : RemoteData String ContactList
    , route : Route
    , search : String
    }


initialModel : Route -> Model
initialModel route =
    { contact = NotRequested
    , contactList = NotRequested
    , route = route
    , search = ""
    }
