module Commands exposing (fetch, fetchContact)

import Decoders exposing (contactDecoder, contactListDecoder)
import Http
import Messages exposing (Msg(FetchContactResult, FetchResult))


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
        Http.send FetchResult request


fetchContact : Int -> Cmd Msg
fetchContact id =
    let
        apiUrl =
            contactsAPIUrl ++ "/" ++ toString id

        request =
            Http.get apiUrl contactDecoder
    in
        Http.send FetchContactResult request


contactsAPIUrl : String
contactsAPIUrl =
    "/api/v1/contacts"
