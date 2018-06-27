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
import Model
    exposing
        ( Model
        , RemoteData(NotRequested, Requesting)
        )
import Navigation
import Routing
    exposing
        ( Route(ListContactsRoute, ShowContactRoute)
        , parse
        , toPath
        )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ContactMsg contactMsg ->
            Contact.Update.update contactMsg model

        ContactListMsg contactListMsg ->
            ContactList.Update.update contactListMsg model

        NavigateTo route ->
            ( model, Navigation.newUrl (toPath route) )

        UpdateSearchQuery value ->
            ( { model | search = value }, Cmd.none )

        UrlChange location ->
            let
                currentRoute =
                    parse location
            in
                urlUpdate { model | route = currentRoute }


urlUpdate : Model -> ( Model, Cmd Msg )
urlUpdate model =
    case model.route of
        ListContactsRoute ->
            case model.contactList of
                NotRequested ->
                    ( model
                    , ContactList.Commands.fetchContactList
                        model.flags.socketUrl
                        1
                        ""
                    )

                _ ->
                    ( model, Cmd.none )

        ShowContactRoute id ->
            ( { model | contact = Requesting }
            , Contact.Commands.fetchContact model.flags.socketUrl id
            )

        _ ->
            ( model, Cmd.none )
