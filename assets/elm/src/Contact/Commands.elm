module Contact.Commands exposing (fetchContact)

import Commands exposing (contactsApiUrl)
import Contact.Decoder as Decoder
import Contact.Messages exposing (ContactMsg(FetchContact))
import Http
import Messages exposing (Msg(ContactMsg))


fetchContact : Int -> Cmd Msg
fetchContact id =
    let
        apiUrl =
            contactsApiUrl ++ "/" ++ toString id
    in
        Decoder.decoder
            |> Http.get apiUrl
            |> Http.send FetchContact
            |> Cmd.map ContactMsg
