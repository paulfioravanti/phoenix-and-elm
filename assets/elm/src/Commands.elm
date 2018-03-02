module Commands exposing (fetchContactList, contactsApiUrl)

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

        request =
            ContactList.Decoder.decoder
                |> Http.get apiUrl
    in
        request
            |> Http.send FetchContactList


contactsApiUrl : String
contactsApiUrl =
    "/api/v1/contacts"
