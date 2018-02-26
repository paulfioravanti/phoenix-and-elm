module Update exposing (update, urlUpdate)

import Commands
import Contact.Update
import ContactList.Update
import Messages
    exposing
        ( Msg
            ( FetchContactSuccess
            , FetchContactError
            , FetchContactListSuccess
            , FetchContactListError
            , NavigateTo
            , Paginate
            , ResetSearch
            , SearchContacts
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
        ( Route(ListContactsRoute, NotFoundRoute, ShowContactRoute)
        , parse
        , toPath
        )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchContactListSuccess json ->
            ContactList.Update.success model json

        FetchContactListError json ->
            ContactList.Update.error model

        FetchContactSuccess json ->
            Contact.Update.success model json

        FetchContactError json ->
            Contact.Update.error model

        NavigateTo route ->
            ( model, Navigation.newUrl (toPath route) )

        Paginate pageNumber ->
            ( model
            , Commands.fetchContactList
                model.flags.socketUrl
                pageNumber
                model.search
            )

        ResetSearch ->
            ( { model | search = "" }
            , Commands.fetchContactList model.flags.socketUrl 1 ""
            )

        SearchContacts ->
            ( { model | contactList = Requesting }
            , Commands.fetchContactList model.flags.socketUrl 1 model.search
            )

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
                    , Commands.fetchContactList model.flags.socketUrl 1 ""
                    )

                _ ->
                    ( model, Cmd.none )

        ShowContactRoute id ->
            ( { model | contact = Requesting }
            , Commands.fetchContact model.flags.socketUrl id
            )

        _ ->
            ( model, Cmd.none )
