module Contact.Commands exposing (fetchContact)

import Commands exposing (apiUrl)
import Contact.Messages exposing (ContactMsg(FetchContact))
import Contact.Request as Request
import GraphQL.Client.Http as Http
import Messages exposing (Msg(ContactMsg))
import Task


fetchContact : Int -> Cmd Msg
fetchContact id =
    id
        |> Request.fetchContact
        |> Http.sendQuery apiUrl
        |> Task.attempt FetchContact
        |> Cmd.map ContactMsg
