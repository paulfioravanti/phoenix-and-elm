module Model exposing (Model, RemoteData(..), initialModel)

import Contact.Model exposing (Contact)
import ContactList.Model exposing (ContactList)
import Routing exposing (Route)


type RemoteData e a
    = Failure e
    | NotRequested
    | Requesting
    | Success a


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
