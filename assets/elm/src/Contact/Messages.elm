module Contact.Messages exposing (ContactMsg(..))

import Contact.Model exposing (Contact)
import GraphQL.Client.Http as Http


type ContactMsg
    = FetchContact (Result Http.Error Contact)
