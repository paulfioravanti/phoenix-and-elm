module Contact.Update exposing (update)

import Contact.Messages exposing (ContactMsg(FetchContact))
import Messages exposing (Msg)
import Model exposing (Model, RemoteData(Failure, Success))


update : ContactMsg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchContact (Ok response) ->
            ( { model | contact = Success response }, Cmd.none )

        FetchContact (Err _) ->
            ( { model | contact = Failure "Contact not found" }, Cmd.none )
