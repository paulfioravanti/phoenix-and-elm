module ContactList.Request exposing (fetchContactList)

import Contact.Request
import ContactList.Model exposing (ContactList)
import GraphQL.Request.Builder as Builder
    exposing
        ( NonNull
        , ObjectType
        , Query
        , Request
        , ValueSpec
        , field
        , int
        , list
        , object
        , with
        )
import GraphQL.Request.Builder.Arg as Arg
import GraphQL.Request.Builder.Variable as Var


{-|
query($searchQuery: String!, $pageNumber: Int!) {
  contacts(search: $searchQuery, page: $pageNumber) {
    entries {
      id
      firstName
      lastName
      gender
      birthDate
      location
      phoneNumber
      email
      headline
      picture
    },
    pageNumber,
    totalEntries
    totalPages,
  }
}
-}
fetchContactList : Int -> String -> Request Query ContactList
fetchContactList page search =
    let
        searchQuery =
            Arg.variable (Var.required "searchQuery" .searchQuery Var.string)

        pageNumber =
            Arg.variable (Var.required "pageNumber" .pageNumber Var.int)

        contactsField =
            Builder.extract
                (field
                    "contacts"
                    [ ( "search", searchQuery ), ( "page", pageNumber ) ]
                    contactListSpec
                )

        params =
            { pageNumber = page
            , searchQuery = search
            }
    in
        contactsField
            |> Builder.queryDocument
            |> Builder.request params


contactListSpec : ValueSpec NonNull ObjectType ContactList vars
contactListSpec =
    let
        contact =
            Contact.Request.contactSpec
    in
        ContactList
            |> object
            |> with (field "entries" [] (list contact))
            |> with (field "pageNumber" [] int)
            |> with (field "totalEntries" [] int)
            |> with (field "totalPages" [] int)
