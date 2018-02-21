module Commands exposing (fetch, fetchContact)

import Decoders exposing (contactDecoder, contactListDecoder)
import Http
import Messages exposing (Msg(FetchContact, FetchContactList))


fetch : Int -> String -> Cmd Msg
fetch page search =
    let
        apiUrl =
            contactsAPIUrl
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
            contactsAPIUrl ++ "/" ++ toString id

        request =
            Http.get apiUrl contactDecoder
    in
        Http.send FetchContact request


contactsAPIUrl : String
contactsAPIUrl =
    "/api/v1/contacts"
