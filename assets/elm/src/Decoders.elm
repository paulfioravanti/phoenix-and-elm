module Decoders exposing (contactListDecoder)

import Contact.Decoder
import Json.Decode exposing (field, int, list, string, succeed)
import Json.Decode.Extra exposing ((|:))
import Model exposing (ContactList)


contactListDecoder : Json.Decode.Decoder ContactList
contactListDecoder =
    succeed
        ContactList
        |: (field "entries" (list Contact.Decoder.decoder))
        |: (field "page_number" int)
        |: (field "total_entries" int)
        |: (field "total_pages" int)
