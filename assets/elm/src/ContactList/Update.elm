module ContactList.Update exposing (update)

import ContactList.Commands
import ContactList.Messages exposing (Msg(FetchContactList, SearchContacts))
import ContactList.Model exposing (ContactList)
import RemoteData exposing (RemoteData(Failure, Requesting, Success))


update :
    Msg
    -> RemoteData String ContactList
    -> String
    -> ( RemoteData String ContactList, Cmd Msg )
update msg contactList search =
    case msg of
        FetchContactList (Ok response) ->
            ( Success response, Cmd.none )

        FetchContactList (Err error) ->
            ( Failure "Something went wrong...", Cmd.none )

        SearchContacts ->
            ( Requesting, ContactList.Commands.fetchContactList 1 search )
