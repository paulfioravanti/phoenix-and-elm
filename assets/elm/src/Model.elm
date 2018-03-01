module Model
    exposing
        ( Contact
        , ContactList
        , Model
        , RemoteData(..)
        , initialModel
        )

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


type alias ContactList =
    { entries : List Contact
    , pageNumber : Int
    , totalEntries : Int
    , totalPages : Int
    }


type alias Contact =
    { id : Int
    , firstName : String
    , lastName : String
    , gender : Int
    , birthDate : String
    , location : String
    , phoneNumber : String
    , email : String
    , headline : String
    , picture : String
    }


initialModel : Route -> Model
initialModel route =
    { contact = NotRequested
    , contactList = NotRequested
    , route = route
    , search = ""
    }
