module Shared.View exposing (warningMessage)

import Html exposing (Html, div, h4, i, span, text)
import Html.Attributes exposing (class)


warningMessage : String -> String -> Html msg -> Html msg
warningMessage iconClasses message content =
    div [ class "warning" ]
        [ span [ class "fa-stack" ]
            [ i [ class iconClasses ] [] ]
        , h4 []
            [ text message ]
        , content
        ]
