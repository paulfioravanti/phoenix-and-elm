module Subscriptions exposing (subscriptions)

import Messages exposing (Msg)
import Model exposing (Model)
import Phoenix
import Phoenix.Channel as Channel exposing (Channel)
import Phoenix.Socket as Socket


subscriptions : Model -> Sub Msg
subscriptions model =
    let
        socket =
            model.flags.socketUrl
                |> Socket.init

        contactsChannel =
            "contacts"
                |> Channel.init
                |> Channel.withDebug
    in
        [ contactsChannel ]
            |> Phoenix.connect socket
