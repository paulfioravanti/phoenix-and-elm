module Contact.Update exposing (update)

import Contact.Decoder as Decoder
import Contact.Messages
    exposing
        ( ContactMsg(FetchContactSuccess, FetchContactError)
        )
import Json.Decode as Decode
import Messages exposing (Msg)
import Model exposing (Model, RemoteData(Failure, Success))


update : ContactMsg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchContactSuccess json ->
            success model json

        FetchContactError _ ->
            error model


success : Model -> Decode.Value -> ( Model, Cmd msg )
success model json =
    let
        response =
            json
                |> Decode.decodeValue Decoder.decoder
    in
        case response of
            Ok payload ->
                ( { model | contact = Success payload }, Cmd.none )

            Err _ ->
                ( { model | contact = Failure "Error while decoding contact" }
                , Cmd.none
                )


error : Model -> ( Model, Cmd msg )
error model =
    ( { model | contact = Failure "Contact not found" }, Cmd.none )
