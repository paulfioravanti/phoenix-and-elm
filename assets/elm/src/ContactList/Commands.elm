module ContactList.Commands exposing (fetchContactList)

import Commands exposing (graphqlUrl)
import ContactList.Messages exposing (ContactListMsg(FetchContactList))
import ContactList.Request
import GraphQL.Client.Http
import Messages exposing (Msg(ContactListMsg))
import Task exposing (Task)


fetchContactList : Int -> String -> Cmd Msg
fetchContactList pageNumber search =
    search
        |> ContactList.Request.fetchContactList pageNumber
        |> GraphQL.Client.Http.sendQuery graphqlUrl
        |> Task.attempt FetchContactList
        |> Cmd.map ContactListMsg
