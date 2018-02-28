module Commands exposing (fetchContactList, fetchContact, sendContactQuery)

import Decoders exposing (contactDecoder, contactListDecoder)
import GraphQL.Request.Builder exposing (..)
import GraphQL.Request.Builder.Arg as Arg
import GraphQL.Request.Builder.Variable as Var
import GraphQL.Client.Http as GraphQLClient
import Http
import Messages
    exposing
        ( Msg(FetchContact, FetchContactRequest, FetchContactList)
        )
import Model exposing (Contact, PageNumber)
import Task exposing (Task)


fetchContactList : PageNumber -> String -> Cmd Msg
fetchContactList page search =
    let
        apiUrl =
            contactsApiUrl
                ++ "?page="
                ++ (toString page)
                ++ "&search="
                ++ search

        request =
            Http.get apiUrl contactListDecoder
    in
        Http.send FetchContactList request


fetchContact : Int -> Cmd Msg
fetchContact id =
    let
        apiUrl =
            contactsApiUrl ++ "/" ++ toString id

        request =
            Http.get apiUrl contactDecoder
    in
        Http.send FetchContact request


sendContactQuery : Int -> Cmd Msg
sendContactQuery id =
    id
        |> fetchContactRequest
        |> sendQueryRequest
        |> Task.attempt FetchContactRequest


fetchContactRequest : Int -> Request Query Contact
fetchContactRequest id =
    let
        contactID =
            Var.required "contactID" .contactID Var.int

        contact =
            Contact
                |> object
                |> with (field "id" [] int)
                |> with (field "firstName" [] string)
                |> with (field "lastName" [] string)
                |> with (field "gender" [] int)
                |> with (field "birthDate" [] string)
                |> with (field "location" [] string)
                |> with (field "phoneNumber" [] string)
                |> with (field "email" [] string)
                |> with (field "headline" [] string)
                |> with (field "picture" [] string)

        queryRoot =
            extract
                (field
                    "contact"
                    [ ( "id", Arg.variable contactID ) ]
                    contact
                )
    in
        queryRoot
            |> queryDocument
            |> request { contactID = id }


sendQueryRequest : Request Query a -> Task GraphQLClient.Error a
sendQueryRequest request =
    request
        |> GraphQLClient.sendQuery graphqlUrl


graphqlUrl : String
graphqlUrl =
    "/graph"


contactsApiUrl : String
contactsApiUrl =
    "/api/v1/contacts"
