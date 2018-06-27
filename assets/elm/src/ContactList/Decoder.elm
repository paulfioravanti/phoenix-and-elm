module ContactList.Decoder exposing (decoder)

import Contact.Decoder
import ContactList.Model exposing (ContactList)
import Json.Decode as Decode exposing (field, int, list)
import Json.Decode.Extra exposing ((|:))


decoder : Decode.Decoder ContactList
decoder =
    let
        contact =
            Contact.Decoder.decoder
    in
        Decode.succeed
            ContactList
            |: field "entries" (list contact)
            |: field "page_number" int
            |: field "total_entries" int
            |: field "total_pages" int
