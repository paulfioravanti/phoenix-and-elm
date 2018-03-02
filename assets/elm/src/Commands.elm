module Commands exposing (fetchContactList, fetchContact)

import Contact.Decoder
import ContactList.Decoder
import Http
import Messages exposing (Msg(FetchContact, FetchContactList))


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
        Http.send FetchContactList request


fetchContact : Int -> Cmd Msg
fetchContact id =
    let
        apiUrl =
            contactsApiUrl ++ "/" ++ toString id

        request =
            Contact.Decoder.decoder
                |> Http.get apiUrl
    in
        Http.send FetchContact request


contactsApiUrl : String
contactsApiUrl =
    "/api/v1/contacts"
