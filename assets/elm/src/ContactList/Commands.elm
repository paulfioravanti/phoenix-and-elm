module ContactList.Commands exposing (fetchContactList)

import ContactList.Request
import GraphQL.Client.Http
import Messages exposing (Msg(FetchContactListRequest))
import Task exposing (Task)


fetchContactList : Int -> String -> Cmd Msg
fetchContactList pageNumber search =
    search
        |> ContactList.Request.fetchContactList pageNumber
        |> GraphQL.Client.Http.sendQuery graphqlUrl
        |> Task.attempt FetchContactListRequest


graphqlUrl : String
graphqlUrl =
    "/graph"
