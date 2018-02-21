module Shared.View exposing (warningMessage, backToHomeLink)

import Html exposing (Html, a, div, h4, i, span, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Messages exposing (Msg(NavigateTo))
import Routing exposing (Route(ListContactsRoute))


warningMessage : String -> String -> Html Msg -> Html Msg
warningMessage iconClasses message content =
    div [ class "warning" ]
        [ span [ class "fa-stack" ]
            [ i [ class iconClasses ] [] ]
        , h4 []
            [ text message ]
        , content
        ]


backToHomeLink : Html Msg
backToHomeLink =
    a [ onClick (NavigateTo ListContactsRoute) ]
        [ text "←  Back to contact list" ]
