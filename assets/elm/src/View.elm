module View exposing (view)

import Contact.View
import ContactList.View
import Html exposing (Html, div, h1, header, section, text)
import Html.Attributes exposing (class)
import Messages exposing (Msg)
import Model exposing (Model)
import Routing
    exposing
        ( Route(ListContactsRoute, NotFoundRoute, ShowContactRoute)
        )
import Shared.View


view : Model -> Html Msg
view model =
    section []
        [ header [ class "main-header" ]
            [ h1 []
                [ text "Phoenix and Elm: A real use case" ]
            ]
        , div []
            [ page model ]
        ]


page : Model -> Html Msg
page model =
    case model.route of
        ListContactsRoute ->
            ContactList.View.view model

        -- unused variable is `id`
        ShowContactRoute _ ->
            Contact.View.view model

        NotFoundRoute ->
            Shared.View.warningMessage
                "fa fa-meh-o fa-stack-2x"
                "Page not found"
                Shared.View.backToHomeLink
