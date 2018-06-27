module Update exposing (update, urlUpdate)

import Contact.Commands
import Contact.Update
import ContactList.Commands
import ContactList.Update
import Messages
    exposing
        ( Msg
            ( ContactMsg
            , ContactListMsg
            , ResetSearch
            , RoutingMsg
            , UpdateSearchQuery
            , UrlChange
            )
        )
import Model exposing (Model)
import RemoteData exposing (RemoteData(NotRequested, Requesting))
import Routing exposing (Route(ListContactsRoute, ShowContactRoute))
import Routing.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ContactMsg contactMsg ->
            let
                ( contact, cmd ) =
                    Contact.Update.update contactMsg
            in
                ( { model | contact = contact }, Cmd.map ContactMsg cmd )

        ContactListMsg contactListMsg ->
            let
                ( contactList, cmd ) =
                    model.contactList
                        |> ContactList.Update.update contactListMsg model.search
            in
                ( { model | contactList = contactList }
                , Cmd.map ContactListMsg cmd
                )

        RoutingMsg routingMsg ->
            ( model, Routing.Update.update routingMsg )

        ResetSearch ->
            ( { model | search = "" }, fetchAllContacts )

        UpdateSearchQuery value ->
            ( { model | search = value }, Cmd.none )

        UrlChange location ->
            let
                currentRoute =
                    Routing.parse location
            in
                urlUpdate { model | route = currentRoute }


urlUpdate : Model -> ( Model, Cmd Msg )
urlUpdate model =
    case model.route of
        ListContactsRoute ->
            case model.contactList of
                NotRequested ->
                    ( model, fetchAllContacts )

                _ ->
                    ( model, Cmd.none )

        ShowContactRoute id ->
            ( { model | contact = Requesting }
            , id
                |> Contact.Commands.fetchContact
                |> Cmd.map ContactMsg
            )

        _ ->
            ( model, Cmd.none )


fetchAllContacts : Cmd Msg
fetchAllContacts =
    1
        |> ContactList.Commands.fetchContactList ""
        |> Cmd.map ContactListMsg
