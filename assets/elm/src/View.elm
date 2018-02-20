module View exposing (view)

import Common.View exposing (warningMessage, backToHomeLink)
import Contact.View exposing (showContactView)
import ContactList.View exposing (indexView)
import Html exposing (Html, div, h1, header, section, text)
import Html.Attributes exposing (class)
import Messages exposing (Msg)
import Model exposing (Model)
import Routing exposing (Route(HomeIndexRoute, NotFoundRoute, ShowContactRoute))


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
            indexView model

        ShowContactRoute id ->
            showContactView model

        NotFoundRoute ->
            notFoundView


notFoundView : Html Msg
notFoundView =
    warningMessage "fa fa-meh-o fa-stack-2x" "Page not found" backToHomeLink
