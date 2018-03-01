module Contact.Messages exposing (ContactMsg(..))

import GraphQL.Client.Http as Http
import Model exposing (Contact)


type ContactMsg
    = FetchContact (Result Http.Error Contact)
