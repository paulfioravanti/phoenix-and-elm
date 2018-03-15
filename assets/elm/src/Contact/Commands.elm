module Contact.Commands exposing (fetchContact)

import Commands exposing (contactsApiUrl)
import Contact.Decoder as Decoder
import Contact.Messages exposing (Msg(FetchContact))
import Http


fetchContact : Int -> Cmd Msg
fetchContact id =
    let
        apiUrl =
            contactsApiUrl ++ "/" ++ toString id
    in
        Decoder.decoder
            |> Http.get apiUrl
            |> Http.send FetchContact
