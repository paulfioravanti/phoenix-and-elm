module Model
    exposing
        ( ContactList
        , Model
        , Query
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


type alias Model =
    { contact : RemoteData String Contact
    , contactList : RemoteData String ContactList
    , route : Route
    , search : Query
    }


type alias ContactList =
    { entries : List Contact
    , pageNumber : Int
    , totalEntries : Int
    , totalPages : Int
    }


type alias Query =
    String


initialModel : Route -> Model
initialModel route =
    { contact = NotRequested
    , contactList = NotRequested
    , route = route
    , search = ""
    }
