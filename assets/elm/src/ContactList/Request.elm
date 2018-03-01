module ContactList.Request exposing (fetchContactList)

import Contact.Request
import GraphQL.Request.Builder as Builder
    exposing
        ( Document
        , NonNull
        , ObjectType
        , Request
        , Query
        , ValueSpec
        , field
        , int
        , list
        , object
        , onType
        , string
        , with
        )
import GraphQL.Request.Builder.Arg as Arg
import GraphQL.Request.Builder.Variable as Var
import Model exposing (ContactList)


{-|
query($searchQuery: String, $pageNumber: Int) {
  contacts(search: $searchQuery, page: $pageNumber) {
    entries {
      ... on Contact {
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
      }
    },
    pageNumber,
    pageSize,
    totalPages,
    totalEntries
  }
}
-}
fetchContactList : Int -> String -> Request Query ContactList
fetchContactList page search =
    let
        pageNumber =
            Arg.variable (Var.required "pageNumber" .pageNumber Var.int)

        searchQuery =
            Arg.variable (Var.required "searchQuery" .searchQuery Var.string)

        contactsField =
            field
                "contacts"
                [ ( "page", pageNumber ), ( "search", searchQuery ) ]
                contactListSpec

        params =
            { pageNumber = page
            , searchQuery = search
            }
    in
        contactsField
            |> Builder.extract
            |> Builder.queryDocument
            |> Builder.request params


contactListSpec : ValueSpec NonNull ObjectType ContactList vars
contactListSpec =
    let
        contact =
            (Builder.extract
                (Builder.assume
                    (Builder.inlineFragment
                        (Just (onType "Contact"))
                        Contact.Request.contactSpec
                    )
                )
            )
    in
        ContactList
            |> object
            |> with (field "entries" [] (list contact))
            |> with (field "pageNumber" [] int)
            |> with (field "totalEntries" [] int)
            |> with (field "totalPages" [] int)
