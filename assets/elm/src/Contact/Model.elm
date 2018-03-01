module Contact.Model exposing (Contact)


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
