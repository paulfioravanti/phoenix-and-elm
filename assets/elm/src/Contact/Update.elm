module Contact.Update exposing (update)

import Contact.Messages exposing (Msg(FetchContact))
import Contact.Model exposing (Contact)
import RemoteData exposing (RemoteData(Failure, Success))


update : Msg -> ( RemoteData String Contact, Cmd Msg )
update msg =
    case msg of
        FetchContact (Ok response) ->
            ( Success response, Cmd.none )

        FetchContact (Err _) ->
            ( Failure "Contact not found", Cmd.none )
