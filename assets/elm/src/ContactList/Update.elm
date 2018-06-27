module ContactList.Update exposing (update)

import ContactList.Commands
import ContactList.Messages
    exposing
        ( ContactListMsg
            ( FetchContactList
            , Paginate
            , ResetSearch
            , SearchContacts
            )
        )
import Messages exposing (Msg)
import Model exposing (Model, RemoteData(Failure, Requesting, Success))


update : ContactListMsg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchContactList (Ok response) ->
            ( { model | contactList = Success response }, Cmd.none )

        FetchContactList (Err _) ->
            ( { model | contactList = Failure "Something went wrong..." }
            , Cmd.none
            )

        Paginate pageNumber ->
            ( model
            , ContactList.Commands.fetchContactList pageNumber model.search
            )

        ResetSearch ->
            ( { model | search = "" }
            , ContactList.Commands.fetchContactList 1 ""
            )

        SearchContacts ->
            ( { model | contactList = Requesting }
            , ContactList.Commands.fetchContactList 1 model.search
            )
