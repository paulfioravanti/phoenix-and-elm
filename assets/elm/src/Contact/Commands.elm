module Contact.Commands exposing (fetchContact)

import Commands exposing (contactsApiUrl)
import Contact.Decoder
import Http
import Messages exposing (Msg(FetchContact))


fetchContact : Int -> Cmd Msg
fetchContact id =
    let
        apiUrl =
            contactsApiUrl ++ "/" ++ toString id

        request =
            Contact.Decoder.decoder
                |> Http.get apiUrl
    in
        request
            |> Http.send FetchContact
