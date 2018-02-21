module Decoders exposing (contactDecoder, contactListDecoder)

import Json.Decode as JD exposing (field, int, list, string, succeed)
import Json.Decode.Extra exposing ((|:))
import Model exposing (Contact, ContactList)


contactListDecoder : JD.Decoder ContactList
contactListDecoder =
    succeed
        ContactList
        |: (field "entries" (list contactDecoder))
        |: (field "page_number" int)
        |: (field "total_entries" int)
        |: (field "total_pages" int)


contactDecoder : JD.Decoder Contact
contactDecoder =
    succeed
        Contact
        |: (field "id" int)
        |: (field "first_name" string)
        |: (field "last_name" string)
        |: (field "gender" int)
        |: (field "birth_date" string)
        |: (field "location" string)
        |: (field "phone_number" string)
        |: (field "email" string)
        |: (field "headline" string)
        |: (field "picture" string)
