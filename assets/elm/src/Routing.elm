module Routing
    exposing
        ( Route(HomeIndexRoute, ShowContactRoute, NotFoundRoute)
        , parse
        , toPath
        )

import Navigation
import UrlParser exposing (Parser, (</>), int, map, oneOf, s)


type Route
    = HomeIndexRoute
    | ShowContactRoute Int
    | NotFoundRoute


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
