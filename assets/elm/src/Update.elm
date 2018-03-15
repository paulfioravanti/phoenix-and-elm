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
            , Paginate
            , ResetSearch
            , UpdateSearchQuery
            , UrlChange
            )
        )
import Model exposing (Model)
import Navigation
import RemoteData exposing (RemoteData(NotRequested, Requesting))
import Routing
    exposing
        ( Route(ListContactsRoute, NotFoundRoute, ShowContactRoute)
        )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ContactMsg msg ->
            let
                ( contact, cmd ) =
                    Contact.Update.update msg model.contact
            in
                ( { model | contact = contact }, Cmd.map ContactMsg cmd )

        ContactListMsg msg ->
            ContactList.Update.update msg model

        NavigateTo route ->
            ( model, Navigation.newUrl (Routing.toPath route) )

        Paginate pageNumber ->
            ( model
            , ContactList.Commands.fetchContactList pageNumber model.search
            )

        ResetSearch ->
            ( { model | search = "" }
            , ContactList.Commands.fetchContactList 1 ""
            )

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
            , id
                |> Contact.Commands.fetchContact
                |> Cmd.map ContactMsg
            )

        _ ->
            ( model, Cmd.none )
