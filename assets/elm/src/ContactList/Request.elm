module ContactList.Request exposing (fetchContactList)

import Contact.Request
import GraphQL.Request.Builder
    exposing
        ( Document
        , NonNull
        , ObjectType
        , Request
        , Query
        , ValueSpec
        , assume
        , extract
        , field
        , inlineFragment
        , int
        , list
        , object
        , onType
        , queryDocument
        , request
        , string
        , with
        )
import GraphQL.Request.Builder.Arg as Arg
import GraphQL.Request.Builder.Variable as Var
import Model exposing (Contact, ContactList)


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
            |> extract
            |> queryDocument
            |> request params


contactListSpec : ValueSpec NonNull ObjectType ContactList vars
contactListSpec =
    let
        listOfContacts =
            list
                (extract
                    (assume
                        (inlineFragment
                            (Just (onType "Contact"))
                            Contact.Request.contactSpec
                        )
                    )
                )
    in
        ContactList
            |> object
            |> with (field "entries" [] listOfContacts)
            |> with (field "pageNumber" [] int)
            |> with (field "totalEntries" [] int)
            |> with (field "totalPages" [] int)
