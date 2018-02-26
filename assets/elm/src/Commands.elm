module Commands exposing (fetchContactList, fetchContact)

import Json.Encode exposing (int, string)
import Messages
    exposing
        ( Msg
            ( FetchContactListSuccess
            , FetchContactListError
            , FetchContactSuccess
            , FetchContactError
            )
        )
import Model exposing (PageNumber, Query)
import Phoenix
import Phoenix.Push as Push


fetchContactList : String -> PageNumber -> Query -> Cmd Msg
fetchContactList socketUrl page search =
    let
        payload =
            Json.Encode.object
                [ ( "page", int page )
                , ( "search", string search )
                ]
    in
        "contacts:fetch"
            |> Push.init "contacts"
            |> Push.withPayload payload
            |> Push.onOk FetchContactListSuccess
            |> Push.onError FetchContactListError
            |> Phoenix.push socketUrl


fetchContact : String -> Int -> Cmd Msg
fetchContact socketUrl id =
    "contact:"
        ++ toString id
        |> Push.init "contacts"
        |> Push.onOk FetchContactSuccess
        |> Push.onError FetchContactError
        |> Phoenix.push socketUrl
