module Contact.Commands exposing (fetchContact)

import Contact.Messages
    exposing
        ( ContactMsg(FetchContactSuccess, FetchContactError)
        )
import Messages exposing (Msg(ContactMsg))
import Phoenix
import Phoenix.Push as Push


fetchContact : String -> Int -> Cmd Msg
fetchContact socketUrl id =
    "contact:"
        ++ toString id
        |> Push.init "contacts"
        |> Push.onOk FetchContactSuccess
        |> Push.onError FetchContactError
        |> Phoenix.push socketUrl
        |> Cmd.map ContactMsg
