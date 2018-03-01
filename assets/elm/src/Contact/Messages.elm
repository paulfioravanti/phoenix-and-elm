module Contact.Messages exposing (ContactMsg(..))

import GraphQL.Client.Http
import Model exposing (Contact)


type ContactMsg
    = FetchContact (Result GraphQL.Client.Http.Error Contact)
