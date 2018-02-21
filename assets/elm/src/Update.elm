module Update exposing (interactions, urlUpdate)

import Commands exposing (fetch, fetchContact)
import Messages
    exposing
        ( Msg
            ( FetchContact
            , FetchContactList
            , HandleFormSubmit
            , HandleSearchInput
            , NavigateTo
            , Paginate
            , ResetSearch
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

        HandleFormSubmit ->
            ( { model | contactList = Requesting }, fetch 1 model.search )

        NavigateTo route ->
            ( model, Navigation.newUrl (toPath route) )

        Paginate pageNumber ->
            ( model, fetch pageNumber model.search )

        ResetSearch ->
            ( { model | search = "" }, fetch 1 "" )

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
                    ( model, fetch 1 "" )

                _ ->
                    ( model, Cmd.none )

        ShowContactRoute id ->
            ( { model | contact = Requesting }, fetchContact id )

        _ ->
            ( model, Cmd.none )
