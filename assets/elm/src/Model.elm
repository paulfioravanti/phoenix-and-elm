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
    , page_number : Int
    , total_entries : Int
    , total_pages : Int
    }


type alias Contact =
    { id : Int
    , first_name : String
    , last_name : String
    , gender : Int
    , birth_date : String
    , location : String
    , phone_number : String
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
