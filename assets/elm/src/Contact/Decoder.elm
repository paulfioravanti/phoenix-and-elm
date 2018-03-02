module Contact.Decoder exposing (decoder)

import Contact.Model exposing (Contact)
import Json.Decode exposing (field, int, string)
import Json.Decode.Extra exposing ((|:))


decoder : Json.Decode.Decoder Contact
decoder =
    Json.Decode.succeed
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
