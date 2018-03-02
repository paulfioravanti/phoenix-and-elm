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
            , NavigateTo
            , UpdateSearchQuery
            , UrlChange
            )
        )
import Model exposing (Model, RemoteData(NotRequested, Requesting))
import Navigation
import Routing
    exposing
        ( Route(ListContactsRoute, NotFoundRoute, ShowContactRoute)
        )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ContactMsg msg ->
            Contact.Update.update msg model

        ContactListMsg msg ->
            ContactList.Update.update msg model

        NavigateTo route ->
            ( model, Navigation.newUrl (Routing.toPath route) )

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
                    ( model, ContactList.Commands.fetchContactList 1 "" )

                _ ->
                    ( model, Cmd.none )

        ShowContactRoute id ->
            ( { model | contact = Requesting }
            , Contact.Commands.fetchContact id
            )

        _ ->
            ( model, Cmd.none )
