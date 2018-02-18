module Commands exposing (..)

import Decoders exposing (contactListDecoder, contactDecoder)
import Http
import Messages exposing (Msg(..))


fetch : Int -> String -> Cmd Msg
fetch page search =
    let
        apiUrl =
            "/api/v1/contacts?page=" ++ (toString page) ++ "&search=" ++ search

        request =
            Http.get apiUrl contactListDecoder
    in
        Http.send FetchResult request


fetchContact : Int -> Cmd Msg
fetchContact id =
    let
        apiUrl =
            "/api/v1/contacts/" ++ toString id

        request =
            Http.get apiUrl contactDecoder
    in
        Http.send FetchContactResult request
