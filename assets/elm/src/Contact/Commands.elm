module Contact.Commands exposing (fetchContact)

import Commands exposing (graphqlUrl)
import Contact.Request
import Contact.Messages exposing (ContactMsg(FetchContact))
import GraphQL.Client.Http
import Messages exposing (Msg(ContactMsg))
import Task exposing (Task)


fetchContact : Int -> Cmd Msg
fetchContact id =
    id
        |> Contact.Request.fetchContact
        |> GraphQL.Client.Http.sendQuery graphqlUrl
        |> Task.attempt FetchContact
        |> Cmd.map ContactMsg
