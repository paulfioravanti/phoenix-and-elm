module Update exposing (update, urlUpdate)

import Commands
import Contact.Commands
import Contact.Update
import ContactList.Update
import Messages
    exposing
        ( Msg
            ( ContactMsg
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
        ContactMsg msg ->
            Contact.Update.update msg model

        FetchContactListSuccess json ->
            ContactList.Update.success model json

        FetchContactListError json ->
            ContactList.Update.error model

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
            , Commands.fetchContactList
                model.flags.socketUrl
                firstPage
                blankSearch
            )

        SearchContacts ->
            ( { model | contactList = Requesting }
            , Commands.fetchContactList
                model.flags.socketUrl
                firstPage
                model.search
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
                    , Commands.fetchContactList
                        model.flags.socketUrl
                        firstPage
                        blankSearch
                    )

                _ ->
                    ( model, Cmd.none )

        ShowContactRoute id ->
            ( { model | contact = Requesting }
            , Contact.Commands.fetchContact model.flags.socketUrl id
            )

        _ ->
            ( model, Cmd.none )


firstPage : Int
firstPage =
    1


blankSearch : String
blankSearch =
    ""
