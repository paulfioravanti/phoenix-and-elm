module Commands exposing (fetchContactList, fetchContact)

import Json.Encode exposing (int, string)
import Messages exposing (Msg(FetchSuccess, FetchError, FetchContactSuccess, FetchContactError))
import Phoenix exposing (..)
import Phoenix.Push as Push


fetchContactList : String -> Int -> String -> Cmd Msg
fetchContactList socketUrl page search =
    let
        payload =
            Json.Encode.object
                [ ( "page", int page )
                , ( "search", string search )
                ]

        push =
            Push.init "contacts" "contacts:fetch"
                |> Push.withPayload payload
                |> Push.onOk FetchSuccess
                |> Push.onError FetchError
    in
        Phoenix.push socketUrl push


fetchContact : String -> Int -> Cmd Msg
fetchContact socketUrl id =
    let
        push =
            Push.init "contacts" ("contact:" ++ toString id)
                |> Push.onOk FetchContactSuccess
                |> Push.onError FetchContactError
    in
        Phoenix.push socketUrl push
