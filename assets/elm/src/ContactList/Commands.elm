module ContactList.Commands exposing (fetchContactList)

import Json.Encode exposing (int, string)
import Messages
    exposing
        ( Msg(FetchContactListSuccess, FetchContactListError)
        )
import Phoenix
import Phoenix.Push as Push


fetchContactList : String -> Int -> String -> Cmd Msg
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
