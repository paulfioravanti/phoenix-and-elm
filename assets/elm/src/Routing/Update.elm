module Routing.Update exposing (update)

import Navigation
import Routing
import Routing.Messages exposing (Msg(NavigateTo))


update : Msg -> Cmd msg
update msg =
    case msg of
        NavigateTo route ->
            Navigation.newUrl (Routing.toPath route)
