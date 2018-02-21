module View exposing (view)

import Contact.View
import ContactList.View
import Html exposing (Html, div, h1, header, section, text)
import Html.Attributes exposing (class)
import Messages exposing (Msg)
import Model exposing (Model)
import Routing
    exposing
        ( Route(HomeIndexRoute, NotFoundRoute, ShowContactRoute)
        )
import Shared.View


view : Model -> Html Msg
view model =
    section []
        [ headerView
        , div []
            [ page model ]
        ]


headerView : Html Msg
headerView =
    header [ class "main-header" ]
        [ h1 []
            [ text "Phoenix and Elm: A real use case" ]
        ]


page : Model -> Html Msg
page model =
    case model.route of
        HomeIndexRoute ->
            ContactList.View.render model

        ShowContactRoute id ->
            Contact.View.render model

        NotFoundRoute ->
            notFoundView


notFoundView : Html Msg
notFoundView =
    Shared.View.warningMessage
        "fa fa-meh-o fa-stack-2x"
        "Page not found"
        Shared.View.backToHomeLink
