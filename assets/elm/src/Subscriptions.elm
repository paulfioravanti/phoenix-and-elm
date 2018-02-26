module Subscriptions exposing (subscriptions)

import Messages exposing (Msg)
import Model exposing (Model)
import Phoenix
import Phoenix.Channel as Channel exposing (Channel)
import Phoenix.Socket as Socket exposing (Socket)


subscriptions : Model -> Sub Msg
subscriptions model =
    let
        socketUrl =
            model.flags.socketUrl
    in
        [ contacts ]
            |> Phoenix.connect (socket socketUrl)


socket : String -> Socket Msg
socket socketUrl =
    Socket.init socketUrl


contacts : Channel Msg
contacts =
    "contacts"
        |> Channel.init
        |> Channel.withDebug
