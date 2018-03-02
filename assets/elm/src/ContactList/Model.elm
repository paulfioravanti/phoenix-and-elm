module ContactList.Model exposing (ContactList)

import Contact.Model exposing (Contact)


type alias ContactList =
    { entries : List Contact
    , pageNumber : Int
    , totalEntries : Int
    , totalPages : Int
    }
