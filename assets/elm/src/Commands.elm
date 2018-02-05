module Commands exposing (..)

-- import Decoders exposing (contactListDecoder, contactDecoder)
-- import Http

import Messages exposing (Msg(..))
import Phoenix exposing (..)
import Phoenix.Push as Push
import Json.Encode as JE


-- API version
-- fetch : Int -> String -> Cmd Msg
-- fetch page search =
--     let
--         apiUrl =
--             "/api/contacts?page=" ++ (toString page) ++ "&search=" ++ search
--         request =
--             Http.get apiUrl contactListDecoder
--     in
--         Http.send FetchResult request


fetch : String -> Int -> String -> Cmd Msg
fetch socketUrl page search =
    let
        payload =
            JE.object
                [ ( "page", JE.int page )
                , ( "search", JE.string search )
                ]

        push =
            Push.init "contacts" "contacts:fetch"
                |> Push.withPayload payload
                |> Push.onOk FetchSuccess
                |> Push.onError FetchError
    in
        Phoenix.push socketUrl push



-- API version
-- fetchContact : Int -> Cmd Msg
-- fetchContact id =
--     let
--         apiUrl =
--             "/api/contacts/" ++ toString id
--         request =
--             Http.get apiUrl contactDecoder
--     in
--         Http.send FetchContactResult request


fetchContact : String -> Int -> Cmd Msg
fetchContact socketUrl id =
    let
        push =
            Push.init "contacts" ("contact:" ++ toString id)
                |> Push.onOk FetchContactSuccess
                |> Push.onError FetchContactError
    in
        Phoenix.push socketUrl push
