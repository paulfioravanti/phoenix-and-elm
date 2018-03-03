module ContactList.Commands exposing (fetchContactList)

import ContactList.Messages
    exposing
        ( ContactListMsg(FetchContactListSuccess, FetchContactListError)
        )
import Json.Encode as Encode exposing (int, string)
import Messages exposing (Msg(ContactListMsg))
import Phoenix
import Phoenix.Push as Push


fetchContactList : String -> Int -> String -> Cmd Msg
fetchContactList socketUrl page search =
    let
        payload =
            Encode.object
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
            |> Cmd.map ContactListMsg
