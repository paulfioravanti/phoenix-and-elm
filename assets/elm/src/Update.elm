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
                    model.contact
                        |> Contact.Update.update msg
            in
                ( { model | contact = contact }, Cmd.map ContactMsg cmd )

        ContactListMsg msg ->
            let
                ( contactList, cmd ) =
                    model.contactList
                        |> ContactList.Update.update msg model.search
            in
                ( { model | contactList = contactList }
                , Cmd.map ContactListMsg cmd
                )

        NavigateTo route ->
            ( model, Navigation.newUrl (Routing.toPath route) )

        ResetSearch ->
            ( { model | search = "" }, fetchContactsBy 1 "" )

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
                    ( model, fetchContactsBy 1 "" )

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


fetchContactsBy : Int -> String -> Cmd Msg
fetchContactsBy page search =
    page
        |> ContactList.Commands.fetchContactList search
        |> Cmd.map ContactListMsg
