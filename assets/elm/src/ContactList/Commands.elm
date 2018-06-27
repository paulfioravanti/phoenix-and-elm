module ContactList.Commands exposing (fetchContactList)

import Commands exposing (contactsApiUrl)
import ContactList.Messages exposing (ContactListMsg(FetchContactList))
import ContactList.Decoder as Decoder
import Http
import Messages exposing (Msg(ContactListMsg))


fetchContactList : Int -> String -> Cmd Msg
fetchContactList page search =
    let
        apiUrl =
            contactsApiUrl
                ++ "?search="
                ++ search
                ++ "&page="
                ++ toString page
    in
        Decoder.decoder
            |> Http.get apiUrl
            |> Http.send FetchContactList
            |> Cmd.map ContactListMsg
