module ContactList.View exposing (view)

import Contact.View
import ContactList.Messages
    exposing
        ( ContactListMsg(Paginate, ResetSearch, SearchContacts)
        )
import ContactList.Model exposing (ContactList)
import Html exposing (Html, a, div, form, h3, input, li, text)
import Html.Attributes
    exposing
        ( class
        , classList
        , id
        , type_
        , placeholder
        , value
        )
import Html.Events exposing (onClick, onInput, onSubmit)
import Html.Keyed as Keyed
import Messages
    exposing
        ( Msg(ContactListMsg, UpdateSearchQuery)
        )
import Model
    exposing
        ( Model
        , RemoteData(NotRequested, Requesting, Failure, Success)
        )
import Shared.View


view : Model -> Html Msg
view model =
    div [ id "home_index" ]
        (renderContacts model)


renderContacts : Model -> List (Html Msg)
renderContacts model =
    case model.contactList of
        NotRequested ->
            [ text "" ]

        Requesting ->
            [ searchSection model
            , Shared.View.warningMessage
                "fa fa-spin fa-cog fa-2x fa-fw"
                "Searching for contacts"
                (text "")
            ]

        Failure error ->
            [ Shared.View.warningMessage
                "fa fa-meh-o fa-stack-2x"
                error
                (text "")
            ]

        Success page ->
            [ searchSection model
            , paginationList page
            , div []
                [ contactsList model page ]
            , paginationList page
            ]


searchSection : Model -> Html Msg
searchSection model =
    div [ class "filter-wrapper" ]
        [ div [ class "overview-wrapper" ]
            [ h3 []
                [ text (renderHeader model) ]
            ]
        , div [ class "form-wrapper" ]
            [ form [ onSubmit (ContactListMsg SearchContacts) ]
                [ resetButton model "reset"
                , input
                    [ type_ "search"
                    , placeholder "Search contacts..."
                    , value model.search
                    , onInput UpdateSearchQuery
                    ]
                    []
                ]
            ]
        ]


renderHeader : Model -> String
renderHeader model =
    case model.contactList of
        Success page ->
            headerText page.totalEntries

        _ ->
            ""


headerText : Int -> String
headerText totalEntries =
    let
        contactWord =
            if totalEntries == 1 then
                "contact"
            else
                "contacts"
    in
        if totalEntries == 0 then
            ""
        else
            toString totalEntries ++ " " ++ contactWord ++ " found"


contactsList : Model -> ContactList -> Html Msg
contactsList model page =
    if page.totalEntries > 0 then
        page
            |> .entries
            |> List.map Contact.View.showView
            |> Keyed.node "div" [ class "cards-wrapper" ]
    else
        Shared.View.warningMessage
            "fa fa-meh-o fa-stack-2x"
            "No contacts found..."
            (resetButton model "btn")


paginationList : ContactList -> Html Msg
paginationList page =
    page
        |> .totalPages
        |> List.range 1
        |> List.map (paginationLink page.pageNumber)
        |> Keyed.ul [ class "pagination" ]


paginationLink : Int -> Int -> ( String, Html Msg )
paginationLink currentPage page =
    let
        classes =
            classList [ ( "active", currentPage == page ) ]
    in
        ( toString page
        , li []
            [ a [ classes, onClick (ContactListMsg (Paginate page)) ] [] ]
        )


resetButton : Model -> String -> Html Msg
resetButton model className =
    let
        hidden =
            model.search == ""

        classes =
            classList [ ( className, True ), ( "hidden", hidden ) ]
    in
        a [ classes, onClick (ContactListMsg ResetSearch) ]
            [ text "Reset search" ]
