module Contact.Update exposing (update)

import Contact.Decoder
import Contact.Messages
    exposing
        ( ContactMsg(FetchContactSuccess, FetchContactError)
        )
import Json.Decode
import Messages exposing (Msg)
import Model exposing (Model, RemoteData(Failure, Success))


update : ContactMsg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchContactSuccess json ->
            success model json

        FetchContactError json ->
            error model


success : Model -> Json.Decode.Value -> ( Model, Cmd msg )
success model json =
    let
        response =
            json
                |> Json.Decode.decodeValue Contact.Decoder.decoder
    in
        case response of
            Ok payload ->
                ( { model | contact = Success payload }, Cmd.none )

            Err err ->
                ( { model | contact = Failure "Error while decoding contact" }
                , Cmd.none
                )


error : Model -> ( Model, Cmd msg )
error model =
    ( { model | contact = Failure "Contact not found" }, Cmd.none )
