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
    = NotRequested
    | Requesting
    | Failure e
    | Success a


type alias Model =
    { contactList : RemoteData String ContactList
    , search : String
    , route : Route
    , contact : RemoteData String Contact
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
    { contactList = NotRequested
    , search = ""
    , route = route
    , contact = NotRequested
    }
