module Update exposing (interactions, urlUpdate)

import Commands
import Messages
    exposing
        ( Msg
            ( FetchContact
            , FetchContactList
            , HandleSearchInput
            , NavigateTo
            , Paginate
            , ResetSearch
            , SearchContacts
            , UrlChange
            )
        )
import Model
    exposing
        ( Model
        , RemoteData(Failure, NotRequested, Requesting, Success)
        )
import Navigation
import Routing
    exposing
        ( Route(ListContactsRoute, NotFoundRoute, ShowContactRoute)
        , parse
        , toPath
        )


interactions : Msg -> Model -> ( Model, Cmd Msg )
interactions msg model =
    case msg of
        FetchContact (Ok response) ->
            ( { model | contact = Success response }, Cmd.none )

        FetchContact (Err error) ->
            ( { model | contact = Failure "Contact not found" }, Cmd.none )

        FetchContactList (Ok response) ->
            ( { model | contactList = Success response }, Cmd.none )

        FetchContactList (Err error) ->
            ( { model | contactList = Failure "Something went wrong..." }
            , Cmd.none
            )

        HandleSearchInput value ->
            ( { model | search = value }, Cmd.none )

        NavigateTo route ->
            ( model, Navigation.newUrl (toPath route) )

        Paginate pageNumber ->
            ( model, Commands.fetchContactList pageNumber model.search )

        ResetSearch ->
            ( { model | search = "" }, Commands.fetchContactList 1 "" )

        SearchContacts ->
            ( { model | contactList = Requesting }
            , Commands.fetchContactList 1 model.search
            )

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
                    ( model, Commands.fetchContactList 1 "" )

                _ ->
                    ( model, Cmd.none )

        ShowContactRoute id ->
            ( { model | contact = Requesting }, Commands.fetchContact id )

        _ ->
            ( model, Cmd.none )
