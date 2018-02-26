module Subscriptions exposing (subscriptions)

import Messages exposing (Msg)
import Model exposing (Model)
import Phoenix
import Phoenix.Channel as Channel exposing (Channel)
import Phoenix.Socket as Socket


subscriptions : Model -> Sub Msg
subscriptions model =
    let
        socketUrl =
            model.flags.socketUrl

        socket =
            Socket.init socketUrl
    in
        [ contacts ]
            |> Phoenix.connect socket


contacts : Channel Msg
contacts =
    "contacts"
        |> Channel.init
        |> Channel.withDebug
