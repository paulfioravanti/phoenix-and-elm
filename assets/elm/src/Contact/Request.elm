module Contact.Request exposing (fetchContact)

import GraphQL.Request.Builder
    exposing
        ( Document
        , NonNull
        , ObjectType
        , Request
        , Query
        , ValueSpec
        , field
        , int
        , object
        , string
        , with
        )
import GraphQL.Request.Builder.Arg as Arg
import GraphQL.Request.Builder.Variable as Var
import Model exposing (Contact)


fetchContact : Int -> Request Query Contact
fetchContact id =
    let
        contactID =
            Arg.variable (Var.required "contactID" .contactID Var.int)

        contactField =
            field
                "contact"
                [ ( "id", contactID ) ]
                contactSpec

        params =
            { contactID = id }
    in
        contactField
            |> GraphQL.Request.Builder.extract
            |> GraphQL.Request.Builder.queryDocument
            |> GraphQL.Request.Builder.request params


contactSpec : ValueSpec NonNull ObjectType Contact vars
contactSpec =
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
