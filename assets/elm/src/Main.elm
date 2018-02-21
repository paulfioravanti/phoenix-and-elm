module Main exposing (main)

import Messages exposing (Msg(UrlChange))
import Model exposing (Model, initialModel)
import Navigation
import Routing
import Update exposing (update, urlUpdate)
import View exposing (view)


main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parse location

        model =
            initialModel currentRoute
    in
        urlUpdate model
