module ContactList.Commands exposing (fetchContactList)

import ContactList.Messages exposing (ContactListMsg(FetchContactList))
import Commands exposing (contactsApiUrl)
import ContactList.Decoder
import Http
import Messages exposing (Msg(ContactListMsg))


fetchContactList : Int -> String -> Cmd Msg
fetchContactList page search =
    let
        apiUrl =
            contactsApiUrl
                ++ "?page="
                ++ (toString page)
                ++ "&search="
                ++ search
    in
        ContactList.Decoder.decoder
            |> Http.get apiUrl
            |> Http.send FetchContactList
            |> Cmd.map ContactListMsg
