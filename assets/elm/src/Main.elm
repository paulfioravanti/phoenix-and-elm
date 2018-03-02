module Main exposing (main)

import Messages exposing (Msg(UrlChange))
import Model exposing (Flags, Model)
import Navigation
import Routing
import Subscriptions
import Update
import View


main : Program Flags Model Msg
main =
    Navigation.programWithFlags
        UrlChange
        { init = init
        , view = View.view
        , update = Update.update
        , subscriptions = Subscriptions.subscriptions
        }


init : Flags -> Navigation.Location -> ( Model, Cmd Msg )
init flags location =
    location
        |> Routing.parse
        |> Model.initialModel flags
        |> Update.urlUpdate
