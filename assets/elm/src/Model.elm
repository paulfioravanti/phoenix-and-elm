module Model exposing (..)

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
    , search : Query
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


type alias Query =
    String


type alias PageNumber =
    String


initialModel : Flags -> Route -> Model
initialModel flags route =
    { contact = NotRequested
    , contactList = NotRequested
    , flags = flags
    , route = route
    , search = ""
    }
