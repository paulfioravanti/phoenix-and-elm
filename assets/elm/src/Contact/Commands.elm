module Contact.Commands exposing (fetchContact)

import Commands exposing (graphqlUrl)
import Contact.Request
import GraphQL.Client.Http
import Messages exposing (Msg(FetchContact))
import Task exposing (Task)


fetchContact : Int -> Cmd Msg
fetchContact id =
    id
        |> Contact.Request.fetchContact
        |> GraphQL.Client.Http.sendQuery graphqlUrl
        |> Task.attempt FetchContact
