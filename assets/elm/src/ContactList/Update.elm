module ContactList.Update exposing (update)

import ContactList.Messages exposing (ContactListMsg(FetchContactList))
import Messages exposing (Msg)
import Model exposing (Model, RemoteData(Failure, Success))


update : ContactListMsg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchContactList (Ok response) ->
            ( { model | contactList = Success response }, Cmd.none )

        FetchContactList (Err error) ->
            ( { model | contactList = Failure "Something went wrong..." }
            , Cmd.none
            )
