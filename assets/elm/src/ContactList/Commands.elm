module ContactList.Commands exposing (fetchContactList)

import Commands exposing (contactsApiUrl)
import ContactList.Decoder as Decoder
import ContactList.Messages exposing (Msg(FetchContactList))
import Http


fetchContactList : String -> Int -> Cmd Msg
fetchContactList search page =
    let
        apiUrl =
            contactsApiUrl
                ++ "?search="
                ++ search
                ++ "&page="
                ++ (toString page)
    in
        Decoder.decoder
            |> Http.get apiUrl
            |> Http.send FetchContactList
