module ContactList.Update exposing (success, error)

import ContactList.Decoder
import Json.Decode
import Model exposing (Model, RemoteData(Failure, Success))


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
