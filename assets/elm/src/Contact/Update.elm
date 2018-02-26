module Contact.Update exposing (success, error)

import Decoders exposing (contactDecoder)
import Json.Decode
import Model exposing (Model, RemoteData(Failure, Success))


success : Model -> Json.Decode.Value -> ( Model, Cmd msg )
success model json =
    let
        response =
            json
                |> Json.Decode.decodeValue contactDecoder
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
