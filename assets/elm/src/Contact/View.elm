module Contact.View exposing (view, showView)

import Contact.Model exposing (Contact)
import Html exposing (Html, div, h3, h4, header, i, img, li, p, text, ul)
import Html.Attributes exposing (class, classList, id, src)
import Html.Events exposing (onClick)
import Messages exposing (Msg(NavigateTo))
import Model
    exposing
        ( Model
        , RemoteData(NotRequested, Requesting, Failure, Success)
        )
import Routing exposing (Route(ShowContactRoute))
import Shared.View


view : Model -> Html Msg
view model =
    case model.contact of
        NotRequested ->
            text ""

        Requesting ->
            Shared.View.warningMessage
                "fa fa-spin fa-cog fa-2x fa-fw"
                "Fetching contact"
                (text "")

        Failure error ->
            Shared.View.warningMessage
                "fa fa-meh-o fa-stack-2x"
                error
                Shared.View.backToHomeLink

        Success contact ->
            showDetailView contact


showView : Contact -> ( String, Html Msg )
showView contact =
    let
        classes =
            classList
                [ ( "card", True )
                , ( "male", contact.gender == 0 )
                , ( "female", contact.gender == 1 )
                ]
    in
        ( toString contact.id
        , div [ classes, onClick (NavigateTo (ShowContactRoute contact.id)) ]
            [ div [ class "inner" ]
                [ cardHeader contact
                , cardBody contact
                ]
            ]
        )


showDetailView : Contact -> Html Msg
showDetailView contact =
    let
        classes =
            classList
                [ ( "person-detail", True )
                , ( "male", contact.gender == 0 )
                , ( "female", contact.gender == 1 )
                ]

        ( _, content ) =
            showView contact
    in
        div [ id "contacts_show" ]
            [ header []
                [ h3 []
                    [ text "Person detail" ]
                ]
            , Shared.View.backToHomeLink
            , div [ classes ]
                [ content ]
            ]


cardHeader : Contact -> Html Msg
cardHeader contact =
    let
        fullName =
            contact.firstName ++ " " ++ contact.lastName
    in
        header []
            [ div [ class "avatar-wrapper" ]
                [ img [ class "avatar", src contact.picture ] [] ]
            , div [ class "info-wrapper" ]
                [ h4 []
                    [ text fullName ]
                , ul [ class "meta" ]
                    [ li []
                        [ i [ class "fa fa-map-marker" ] []
                        , text contact.location
                        ]
                    , li []
                        [ i [ class "fa fa-birthday-cake" ] []
                        , text contact.birthDate
                        ]
                    ]
                ]
            ]


cardBody : Contact -> Html Msg
cardBody contact =
    div [ class "card-body" ]
        [ div [ class "headline" ]
            [ p []
                [ text contact.headline ]
            ]
        , ul [ class "contact-info" ]
            [ li []
                [ i [ class "fa fa-phone" ] []
                , text contact.phoneNumber
                ]
            , li []
                [ i [ class "fa fa-envelope" ] []
                , text contact.email
                ]
            ]
        ]
