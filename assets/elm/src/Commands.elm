module Commands exposing (fetchContactList, fetchContact)

import Decoders exposing (contactDecoder, contactListDecoder)
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
            Http.get apiUrl contactListDecoder
    in
        Http.send FetchContactList request


fetchContact : Int -> Cmd Msg
fetchContact id =
    let
        apiUrl =
            contactsApiUrl ++ "/" ++ toString id

        request =
            Http.get apiUrl contactDecoder
    in
        Http.send FetchContact request


contactsApiUrl : String
contactsApiUrl =
    "/api/v1/contacts"
