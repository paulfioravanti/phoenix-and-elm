module Model
    exposing
        ( Flags
        , Model
        , RemoteData(..)
        , initialModel
        )

import Contact.Model exposing (Contact)
import ContactList.Model exposing (ContactList)
import Routing exposing (Route)


type RemoteData e a
    = Failure e
    | NotRequested
    | Requesting
    | Success a


type alias Flags =
    { socketUrl : String }


type alias Model =
    { contact : RemoteData String Contact
    , contactList : RemoteData String ContactList
    , flags : Flags
    , route : Route
    , search : String
    }


initialModel : Flags -> Route -> Model
initialModel flags route =
    { contact = NotRequested
    , contactList = NotRequested
    , flags = flags
    , route = route
    , search = ""
    }
