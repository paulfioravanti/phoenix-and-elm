module Model
    exposing
        ( Contact
        , ContactList
        , Model
        , PageNumber
        , Query
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
    , search : Query
    }


type alias ContactList =
    { entries : List Contact
    , page_number : PageNumber
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


type alias PageNumber =
    Int


type alias Query =
    String


initialModel : Route -> Model
initialModel route =
    { contact = NotRequested
    , contactList = NotRequested
    , route = route
    , search = ""
    }
