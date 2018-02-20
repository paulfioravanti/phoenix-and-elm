module Routing
    exposing
        ( Route(HomeIndexRoute, NotFoundRoute, ShowContactRoute)
        , parse
        , toPath
        )

import Navigation
import UrlParser exposing (Parser, (</>), int, map, oneOf, s)


type Route
    = HomeIndexRoute
    | NotFoundRoute
    | ShowContactRoute Int


toPath : Route -> String
toPath route =
    case route of
        HomeIndexRoute ->
            "/"

        ShowContactRoute id ->
            "/contacts/" ++ toString id

        NotFoundRoute ->
            "/not-found"


parse : Navigation.Location -> Route
parse location =
    case UrlParser.parsePath matchers location of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map HomeIndexRoute (s "")
        , map ShowContactRoute (s "contacts" </> int)
        ]
