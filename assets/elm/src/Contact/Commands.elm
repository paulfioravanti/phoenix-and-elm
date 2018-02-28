module Contact.Commands exposing (fetchContact)

import Contact.Request
import GraphQL.Client.Http
import Messages exposing (Msg(FetchContactRequest))
import Task exposing (Task)


fetchContact : Int -> Cmd Msg
fetchContact id =
    id
        |> Contact.Request.fetchContact
        |> GraphQL.Client.Http.sendQuery graphqlUrl
        |> Task.attempt FetchContactRequest


graphqlUrl : String
graphqlUrl =
    "/graph"
