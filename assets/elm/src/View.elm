module View exposing (..)

import Contact.View
import ContactList.View exposing (indexView)
import Html exposing (..)
import Html.Attributes exposing (..)
import Messages exposing (..)
import Model exposing (..)
import Routing exposing (Route(..))
import Shared.View exposing (warningMessage, backToHomeLink)


view : Model -> Html Msg
view model =
    section
        []
        [ headerView
        , div []
            [ page model ]
        ]


headerView : Html Msg
headerView =
    header
        [ class "main-header" ]
        [ h1
            []
            [ text "Phoenix and Elm: A real use case" ]
        ]


page : Model -> Html Msg
page model =
    case model.route of
        ListContactsRoute ->
            indexView model

        ShowContactRoute id ->
            Contact.View.render model

        NotFoundRoute ->
            notFoundView


notFoundView : Html Msg
notFoundView =
    warningMessage
        "fa fa-meh-o fa-stack-2x"
        "Page not found"
        backToHomeLink
