module ContactList.Update exposing (update)

import ContactList.Commands
import ContactList.Messages
    exposing
        ( Msg
            ( FetchContactList
            , Paginate
            , SearchContacts
            )
        )
import ContactList.Model exposing (ContactList)
import RemoteData exposing (RemoteData(Failure, Requesting, Success))


update :
    Msg
    -> String
    -> RemoteData String ContactList
    -> ( RemoteData String ContactList, Cmd Msg )
update msg search contactList =
    case msg of
        FetchContactList (Ok response) ->
            ( Success response, Cmd.none )

        FetchContactList (Err error) ->
            ( Failure "Something went wrong...", Cmd.none )

        Paginate pageNumber ->
            ( contactList
            , pageNumber
                |> ContactList.Commands.fetchContactList search
            )

        SearchContacts ->
            ( Requesting
            , 1
                |> ContactList.Commands.fetchContactList search
            )
