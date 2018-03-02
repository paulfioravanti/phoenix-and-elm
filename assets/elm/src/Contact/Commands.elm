module Contact.Commands exposing (fetchContact)

import Messages exposing (Msg(FetchContactSuccess, FetchContactError))
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
