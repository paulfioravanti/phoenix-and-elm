module Model
    exposing
        ( ContactList
        , Flags
        , Model
        , RemoteData(..)
        , initialModel
        )

import Contact.Model exposing (Contact)
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


type alias ContactList =
    { entries : List Contact
    , pageNumber : Int
    , totalEntries : Int
    , totalPages : Int
    }


initialModel : Flags -> Route -> Model
initialModel flags route =
    { contact = NotRequested
    , contactList = NotRequested
    , flags = flags
    , route = route
    , search = ""
    }
