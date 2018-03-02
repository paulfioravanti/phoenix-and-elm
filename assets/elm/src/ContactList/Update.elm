module ContactList.Update exposing (update)

import ContactList.Commands
import ContactList.Decoder
import ContactList.Messages
    exposing
        ( ContactListMsg
            ( FetchContactListSuccess
            , FetchContactListError
            , Paginate
            , ResetSearch
            , SearchContacts
            )
        )
import Json.Decode
import Messages exposing (Msg)
import Model exposing (Model, RemoteData(Failure, Requesting, Success))


update : ContactListMsg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchContactListSuccess json ->
            success model json

        FetchContactListError json ->
            error model

        Paginate pageNumber ->
            ( model
            , ContactList.Commands.fetchContactList
                model.flags.socketUrl
                pageNumber
                model.search
            )

        ResetSearch ->
            ( { model | search = "" }
            , ContactList.Commands.fetchContactList
                model.flags.socketUrl
                1
                ""
            )

        SearchContacts ->
            ( { model | contactList = Requesting }
            , ContactList.Commands.fetchContactList
                model.flags.socketUrl
                1
                model.search
            )


success : Model -> Json.Decode.Value -> ( Model, Cmd msg )
success model json =
    let
        response =
            json
                |> Json.Decode.decodeValue ContactList.Decoder.decoder
    in
        case response of
            Ok payload ->
                ( { model | contactList = Success payload }, Cmd.none )

            Err err ->
                ( { model
                    | contactList = Failure "Error while decoding contact list"
                  }
                , Cmd.none
                )


error : Model -> ( Model, Cmd msg )
error model =
    ( { model | contactList = Failure "Error while fetching contact list" }
    , Cmd.none
    )
