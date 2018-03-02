module ContactList.Commands exposing (fetchContactList)

import Commands exposing (contactsApiUrl)
import ContactList.Decoder
import Http
import Messages exposing (Msg(FetchContactList))


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
