module ContactList.Update exposing (update)

import ContactList.Commands
import ContactList.Messages
    exposing
        ( ContactListMsg(FetchContactList, SearchContacts)
        )
import Messages exposing (Msg)
import Model exposing (Model, RemoteData(Failure, Requesting, Success))


update : ContactListMsg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchContactList (Ok response) ->
            ( { model | contactList = Success response }, Cmd.none )

        FetchContactList (Err error) ->
            ( { model | contactList = Failure "Something went wrong..." }
            , Cmd.none
            )

        SearchContacts ->
            ( { model | contactList = Requesting }
            , ContactList.Commands.fetchContactList 1 model.search
            )
